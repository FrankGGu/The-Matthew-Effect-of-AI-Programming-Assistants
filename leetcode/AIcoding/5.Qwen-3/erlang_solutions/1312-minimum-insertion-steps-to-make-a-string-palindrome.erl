-module(minimum_insertion_steps).
-export([min_insertion_steps/1]).

min_insertion_steps(S) ->
    N = length(S),
    DP = array:new(N, {default, 0}),
    min_insertion_steps(S, N, DP).

min_insertion_steps(_, 0, _) ->
    0;
min_insertion_steps(_, 1, _) ->
    0;
min_insertion_steps(S, N, DP) ->
    I = N - 1,
    J = N - 1,
    min_insertion_steps(S, I, J, DP).

min_insertion_steps(_, _, _, _) ->
    0.

min_insertion_steps(S, I, J, DP) when I < 0 orelse J < 0 ->
    0;
min_insertion_steps(S, I, J, DP) when I == J ->
    0;
min_insertion_steps(S, I, J, DP) ->
    case array:get(I, DP) of
        {ok, Val} when J == array:get(I, DP) ->
            Val;
        _ ->
            case array:get(J, DP) of
                {ok, Val2} when I == array:get(J, DP) ->
                    Val2;
                _ ->
                    case S[I] of
                        S[J] ->
                            Res = min_insertion_steps(S, I - 1, J - 1, DP),
                            array:set(I, J, Res, DP),
                            Res;
                        _ ->
                            Res1 = min_insertion_steps(S, I - 1, J, DP),
                            Res2 = min_insertion_steps(S, I, J - 1, DP),
                            Res = 1 + min(Res1, Res2),
                            array:set(I, J, Res, DP),
                            Res
                    end
            end
    end.