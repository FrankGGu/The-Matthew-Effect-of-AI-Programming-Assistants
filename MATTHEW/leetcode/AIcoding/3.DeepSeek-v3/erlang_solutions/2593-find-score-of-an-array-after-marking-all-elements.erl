-spec find_score(Nums :: [integer()]) -> integer().
find_score(Nums) ->
    {_, Score} = lists:foldl(fun(_, {Marked, Acc}) ->
        case find_min_unmarked(Nums, Marked) of
            none -> {Marked, Acc};
            {Pos, Val} ->
                NewMarked = mark_positions(Pos, Nums, Marked),
                {NewMarked, Acc + Val}
        end
    end, {sets:new(), 0}, lists:seq(1, length(Nums))),
    Score.

find_min_unmarked(Nums, Marked) ->
    lists:foldl(fun({Pos, Val}, Acc) ->
        case sets:is_element(Pos, Marked) of
            true -> Acc;
            false ->
                case Acc of
                    none -> {Pos, Val};
                    {_, MinVal} when Val < MinVal -> {Pos, Val};
                    {_, MinVal} when Val == MinVal andalso Pos < element(1, Acc) -> {Pos, Val};
                    _ -> Acc
                end
        end
    end, none, lists:zip(lists:seq(1, length(Nums)), Nums)).

mark_positions(Pos, Nums, Marked) ->
    Len = length(Nums),
    Left = Pos - 1,
    Right = Pos + 1,
    Marked1 = sets:add_element(Pos, Marked),
    Marked2 = case Left >= 1 of
        true -> sets:add_element(Left, Marked1);
        false -> Marked1
    end,
    case Right =< Len of
        true -> sets:add_element(Right, Marked2);
        false -> Marked2
    end.