-module(minimum_absolute_difference_queries).
-export([min_absolute_difference/2]).

min_absolute_difference(A, queries) ->
    SortedA = lists:sort(A),
    lists:map(fun({x, y}) -> min_abs_diff(SortedA, x, y) end, queries).

min_abs_diff(SortedA, X, Y) ->
    {Min, Max} = {min(X, Y), max(X, Y)},
    lists:foldl(fun(A, Acc) -> 
        case A of
            _ when A < Min -> Acc;
            _ when A > Max -> Acc;
            _ -> 
                case Acc of
                    {ok, D} -> {ok, min(D, abs(A - (Min + Max) div 2))};
                    _ -> {ok, abs(A - (Min + Max) div 2)}
                end
        end
    end, {error, infinity}, SortedA).