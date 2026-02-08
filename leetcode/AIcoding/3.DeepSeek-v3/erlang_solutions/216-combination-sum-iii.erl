-module(combination_sum_iii).

-export([combination_sum3/2]).

combination_sum3(K, N) ->
    Backtrack = fun Backtrack(Start, Path, RemainingK, RemainingN, Acc) ->
        case RemainingK =:= 0 of
            true ->
                case RemainingN =:= 0 of
                    true -> [Path | Acc];
                    false -> Acc
                end;
            false ->
                lists:foldl(fun(I, CurrentAcc) ->
                    if
                        I > RemainingN -> CurrentAcc;
                        true -> Backtrack(I + 1, [I | Path], RemainingK - 1, RemainingN - I, CurrentAcc)
                    end
                end, Acc, lists:seq(Start, 9))
        end
    end,
    lists:reverse(Backtrack(1, [], K, N, [])).