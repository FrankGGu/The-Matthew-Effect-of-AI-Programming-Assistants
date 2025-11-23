-module(solution).
-export([earliest_second_to_mark_indices/2]).

earliest_second_to_mark_indices(Nums, ChangeIndices) ->
    {ok, N} = length(Nums),
    {ok, M} = length(ChangeIndices),
    Low = 1,
    High = M,
    Result = binary_search(Nums, ChangeIndices, Low, High, N, M),
    case Result of
        -1 -> -1;
        _ -> Result
    end.

binary_search(Nums, ChangeIndices, Low, High, N, M) when Low =< High ->
    Mid = (Low + High) div 2,
    case is_possible(Nums, ChangeIndices, Mid, N) of
        true ->
            case binary_search(Nums, ChangeIndices, Low, Mid - 1, N, M) of
                -1 -> Mid;
                Other -> Other
            end;
        false ->
            binary_search(Nums, ChangeIndices, Mid + 1, High, N, M)
    end;
binary_search(_, _, _, _, _, _) -> -1.

is_possible(Nums, ChangeIndices, Mid, N) ->
    LastOccur = maps:new(),
    LastOccur1 = update_last_occur(ChangeIndices, Mid, N, LastOccur),
    case maps:size(LastOccur1) == N of
        false -> false;
        true ->
            Total = 0,
            lists:foldl(fun(Second, {TotalAcc, Possible}) ->
                Index = lists:nth(Second, ChangeIndices),
                case maps:get(Index, LastOccur1, -1) == Second of
                    true ->
                        Needed = lists:nth(Index, Nums),
                        if
                            TotalAcc >= Needed -> {TotalAcc - Needed, Possible};
                            true -> {TotalAcc, false}
                        end;
                    false -> {TotalAcc + 1, Possible}
                end
            end, {Total, true}, lists:seq(1, Mid))
    end.

update_last_occur(ChangeIndices, Mid, N, LastOccur) ->
    lists:foldl(fun(Second, Acc) ->
        Index = lists:nth(Second, ChangeIndices),
        if
            Second =< Mid andalso Index >= 1 andalso Index =< N ->
                maps:put(Index, Second, Acc);
            true -> Acc
        end
    end, LastOccur, lists:seq(1, Mid)).