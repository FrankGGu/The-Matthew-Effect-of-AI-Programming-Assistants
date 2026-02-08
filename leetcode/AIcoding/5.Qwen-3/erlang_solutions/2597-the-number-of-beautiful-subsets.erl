-module(beautiful_subsets).
-export([beautiful_subsets/1]).

beautiful_subsets(Numbers) ->
    Count = 0,
    N = length(Numbers),
    lists:foldl(fun(I, Acc) -> count_subsets(Numbers, I, N, Acc) end, Count, lists:seq(0, N-1)).

count_subsets(_, _, _, Acc) when Acc == 0 -> 0;
count_subsets(Numbers, Index, N, Acc) ->
    Subsets = generate_subsets(Numbers, Index, N),
    lists:foldl(fun(S, A) -> check_subset(S, A) end, Acc, Subsets).

generate_subsets(_, _, 0, _) -> [];
generate_subsets(Numbers, Index, N, Acc) ->
    [lists:sublist(Numbers, Index+1, N - Index) | generate_subsets(Numbers, Index+1, N, Acc)].

check_subset([], Acc) -> Acc + 1;
check_subset([H | T], Acc) ->
    case is_beautiful([H | T]) of
        true -> Acc + 1;
        false -> Acc
    end.

is_beautiful([]) -> true;
is_beautiful([H | T]) ->
    is_beautiful(T, H, T).

is_beautiful([], _, _) -> true;
is_beautiful([X | XS], Y, Original) ->
    if
        X == Y + 1 -> false;
        X == Y - 1 -> false;
        true -> is_beautiful(XS, Y, Original)
    end.