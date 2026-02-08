-module(solution).
-export([num_similar_groups/1]).

num_similar_groups(Strs) ->
    N = length(Strs),
    Visited = array:new([{size, N}, {fixed, true}, {default, false}]),
    Count = 0,
    {Res, _} = lists:foldl(fun(I, {Cnt, V}) ->
        case array:get(I, V) of
            false ->
                {Cnt + 1, dfs(I, Strs, array:set(I, true, V))};
            true ->
                {Cnt, V}
        end
    end, {Count, Visited}, lists:seq(0, N - 1)),
    Res.

dfs(I, Strs, Visited) ->
    lists:foldl(fun(J, V) ->
        case array:get(J, V) of
            false ->
                case is_similar(lists:nth(I + 1, Strs), lists:nth(J + 1, Strs)) of
                    true -> dfs(J, Strs, array:set(J, true, V));
                    false -> V
                end;
            true -> V
        end
    end, Visited, lists:seq(0, length(Strs) - 1)).

is_similar(A, B) ->
    case lists:filter(fun({X, Y}) -> X =/= Y end, lists:zip(A, B)) of
        [] -> true;
        [{X1, Y1}, {X2, Y2}] -> X1 =:= Y2 andalso X2 =:= Y1;
        _ -> false
    end.