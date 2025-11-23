-module(number_of_sets).
-export([number_of_sets/2]).

number_of_sets(n, k) ->
    memo(n, k).

memo(n, k) ->
    memo(n, k, dict:new()).

memo(n, k, Dict) ->
    case dict:find({n, k}, Dict) of
        {ok, Value} ->
            Value;
        error ->
            Value = calculate(n, k, Dict),
            dict:store({n, k}, Value, Dict),
            Value
    end.

calculate(N, 0, _) -> 1;
calculate(N, K, Dict) when N < 2 * K -> 0;
calculate(N, K, Dict) ->
    (memo(N-1, K, Dict) + memo(N-2, K-1, Dict)) rem 1000000007.