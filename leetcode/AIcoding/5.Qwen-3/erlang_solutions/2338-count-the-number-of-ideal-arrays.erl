-module(solution).
-export([ideal_arrays/1]).

ideal_arrays(Nums) ->
    Count = 1,
    Factors = lists:foldl(fun(N, Acc) -> factorize(N, Acc) end, [], Nums),
    lists:foldl(fun(F, Acc) -> multiply(Acc, F) end, Count, Factors).

factorize(1, Acc) -> Acc;
factorize(N, Acc) ->
    Factors = get_factors(N),
    factorize(N div lists:hd(Factors), [Factors | Acc]).

get_factors(N) ->
    get_factors(N, 2, []).

get_factors(N, I, Acc) when I * I > N -> [N | Acc];
get_factors(N, I, Acc) ->
    case N rem I of
        0 -> get_factors(N div I, I, [I | Acc]);
        _ -> get_factors(N, I + 1, Acc)
    end.

multiply(1, _) -> 1;
multiply(_, []) -> 1;
multiply(Acc, [F | Fs]) ->
    multiply(Acc * F, Fs).