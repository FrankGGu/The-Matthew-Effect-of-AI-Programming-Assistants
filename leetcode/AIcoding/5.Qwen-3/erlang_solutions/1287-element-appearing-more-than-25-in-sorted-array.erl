-module(solution).
-export([find_special_integer/1]).

find_special_integer(A) ->
    N = length(A),
    Step = N div 4,
    find_special_integer(A, Step).

find_special_integer(A, Step) ->
    lists:foldl(fun(I, Acc) ->
        case Acc of
            not_found -> check(A, I, Step);
            _ -> Acc
        end
    end, not_found, lists:seq(0, N - 1, Step)).

check(A, I, Step) ->
    N = length(A),
    Count = count(A, I, Step),
    if
        Count > N div 4 -> element(I, A);
        true -> not_found
    end.

count([], _, _) -> 0;
count([H|T], I, Step) ->
    if
        H == element(I, A) -> 1 + count(T, I, Step);
        true -> count(T, I, Step)
    end.