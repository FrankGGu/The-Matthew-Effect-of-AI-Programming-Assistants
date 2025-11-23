-module(solution).
-export([check_arithmetic_subarrays/3]).

check_arithmetic_subarrays(Numbers, L, R) ->
    lists:map(fun({Start, End}) -> is_arithmetic(sublist(Numbers, Start, End)) end, lists:zip(L, R)).

sublist(List, Start, End) ->
    lists:sublist(List, Start + 1, End - Start + 1).

is_arithmetic(List) ->
    case lists:sort(List) of
        [] -> true;
        [H] -> true;
        [H1, H2 | _] -> 
            Diff = H2 - H1,
            is_arithmetic_helper(Diff, H2, tl(List))
    end.

is_arithmetic_helper(_, _, []) -> true;
is_arithmetic_helper(Diff, Prev, [H | T]) ->
    case H - Prev == Diff of
        true -> is_arithmetic_helper(Diff, H, T);
        false -> false
    end.