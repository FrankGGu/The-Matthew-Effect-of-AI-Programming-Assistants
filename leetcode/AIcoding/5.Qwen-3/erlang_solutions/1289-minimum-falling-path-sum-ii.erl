-module(minimum_falling_path_sum_ii).
-export([minFallingPathSum/1]).

minFallingPathSum(Matrix) ->
    N = length(Matrix),
    DP = array:new(N, {default, 0}),
    lists:foreach(fun(I) -> array:set(I, lists:nth(I+1, Matrix), DP) end, lists:seq(0, N-1)),
    lists:foreach(fun(I) ->
        if
            I == 0 -> ok;
            true ->
                Min1 = min_second_min(array:to_list(DP)),
                lists:foreach(fun(J) ->
                    if
                        J == element(1, Min1) -> array:set(J, element(2, Min1) + lists:nth(J+1, lists:nth(I, Matrix)), DP);
                        true -> array:set(J, element(1, Min1) + lists:nth(J+1, lists:nth(I, Matrix)), DP)
                    end
                end, lists:seq(0, N-1))
        end
    end, lists:seq(1, N-1)),
    lists:min(array:to_list(DP)).

min_second_min(List) ->
    min_second_min(List, infinity, infinity).

min_second_min([], M1, M2) ->
    {M1, M2};
min_second_min([H|T], M1, M2) ->
    case H < M1 of
        true ->
            min_second_min(T, H, M1);
        false ->
            case H < M2 of
                true ->
                    min_second_min(T, M1, H);
                false ->
                    min_second_min(T, M1, M2)
            end
    end.