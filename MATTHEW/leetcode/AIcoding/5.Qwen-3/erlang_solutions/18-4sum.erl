-module(solution).
-export([four_sum/2]).

four_sum(Nums, Target) ->
    lists:usort(four_sum(Nums, Target, 0, [], [])).

four_sum([], _, _, _, Acc) ->
    Acc;
four_sum([H|T], Target, Index, Path, Acc) ->
    case length(Path) of
        4 ->
            case lists:sum(Path) of
                Sum when Sum == Target ->
                    four_sum(T, Target, Index + 1, [], [lists:reverse(Path) | Acc]);
                _ ->
                    four_sum(T, Target, Index + 1, [], Acc)
            end;
        _ ->
            case lists:sum(Path) of
                Sum when Sum > Target ->
                    four_sum(T, Target, Index + 1, [], Acc);
                _ ->
                    four_sum(T, Target, Index + 1, [H | Path], Acc)
            end
    end.