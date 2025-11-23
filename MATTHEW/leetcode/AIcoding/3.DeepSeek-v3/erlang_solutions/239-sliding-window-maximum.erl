-spec max_sliding_window(Nums :: [integer()], K :: integer()) -> [integer()].
max_sliding_window(Nums, K) ->
    case Nums of
        [] -> [];
        _ ->
            Q = queue:new(),
            {Q1, _} = lists:foldl(fun(I, {QAcc, Idx}) ->
                while(fun() -> not queue:is_empty(QAcc) end,
                      fun() ->
                          {value, {Val, Pos}} = queue:peek_r(QAcc),
                          case Val < lists:nth(I, Nums) of
                              true -> queue:drop_r(QAcc);
                              false -> QAcc
                          end
                      end),
                QNew = queue:in_r({lists:nth(I, Nums), Idx}, QAcc),
                while(fun() -> not queue:is_empty(QNew) end,
                      fun() ->
                          {{value, {Val, Pos}}, QTemp} = queue:out(QNew),
                          case Pos =< Idx - K of
                              true -> QTemp;
                              false -> queue:in({Val, Pos}, QTemp)
                          end
                      end),
                {QNew, Idx + 1}
            end, {Q, 1}, lists:seq(1, length(Nums))),
            lists:map(fun(I) ->
                {{value, {Val, _}}, _} = queue:out(Q1),
                Val
            end, lists:seq(K, length(Nums)))
    end.

while(Condition, Body) ->
    case Condition() of
        true -> while(Condition, Body());
        false -> Body
    end.