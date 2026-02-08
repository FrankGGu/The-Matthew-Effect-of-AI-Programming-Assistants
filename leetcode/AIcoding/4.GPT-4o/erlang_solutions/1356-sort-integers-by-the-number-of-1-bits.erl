-module(solution).
-export([sort_by_bits/1]).

sort_by_bits(List) ->
    lists:sort(fun({CountA, ValueA}, {CountB, ValueB}) ->
        case CountA - CountB of
            0 -> ValueA < ValueB;
            _ -> CountA < CountB
        end
    end, lists:map(fun(X) -> {popcount(X), X} end, List)).

popcount(N) ->
    case N of
        0 -> 0;
        _ -> 1 + popcount(N band (N - 1))
    end.