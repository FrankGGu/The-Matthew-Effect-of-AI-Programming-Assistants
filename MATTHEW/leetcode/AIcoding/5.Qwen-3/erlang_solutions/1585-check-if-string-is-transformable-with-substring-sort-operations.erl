-module(solution).
-export([is_transformable/2]).

is_transformable(S, T) ->
    is_transformable(S, T, 0, 0).

is_transformable(_, _, _, _) when length(S) /= length(T) -> false;
is_transformable(S, T, I, J) when I == length(S) -> true;
is_transformable(S, T, I, J) when J == length(T) -> false;
is_transformable(S, T, I, J) ->
    case lists:nth(I+1, S) of
        lists:nth(J+1, T) ->
            is_transformable(S, T, I+1, J+1);
        _ ->
            case find_next_char(S, lists:nth(J+1, T), I) of
                false -> false;
                K ->
                    is_transformable(swap(S, I, K), T, I+1, J)
            end
    end.

find_next_char(_, _, Len) when Len >= length(S) -> false;
find_next_char(S, C, I) ->
    case lists:nth(I+1, S) of
        C -> I;
        _ -> find_next_char(S, C, I+1)
    end.

swap(S, I, K) ->
    A = lists:sublist(S, I+1),
    B = lists:sublist(S, K+1, I-K),
    C = lists:sublist(S, K+1),
    lists:append(A, B, C).