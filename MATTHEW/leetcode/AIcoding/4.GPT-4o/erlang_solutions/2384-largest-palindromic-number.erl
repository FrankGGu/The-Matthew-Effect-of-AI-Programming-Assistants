-module(solution).
-export([largest_palindromic/1]).

largest_palindromic(N) ->
    digits = lists:duplicate(N, $9),
    max_palindrome = lists:foldl(fun(_, Acc) -> 
        case Acc of
            [] -> [];
            _ -> [digits_to_string(digits), lists:reverse(digits_to_string(digits))]
        end
    end, [], lists:seq(1, N)),
    lists:sort(max_palindrome).

digits_to_string(Digits) ->
    lists:flatten(lists:map(fun(D) -> [D] end, Digits)).