-module(solution).
-export([largeGroupPositions/1]).

largeGroupPositions(S) ->
    large_group_positions(S, 0, [], 0).

large_group_positions([], _, Acc, _) ->
    lists:reverse(Acc);
large_group_positions(S, Index, Acc, Count) ->
    case lists:sublist(S, Index, 1) of
        [C] ->
            case lists:sublist(S, Index + 1, 1) of
                [C] -> large_group_positions(S, Index + 1, Acc, Count + 1);
                _ -> 
                    if Count >= 2 ->
                        large_group_positions(S, Index + 1, [[Index - Count, Index]] ++ Acc, 0);
                    true ->
                        large_group_positions(S, Index + 1, Acc, 0)
                    end
            end;
        _ -> Acc
    end.