-module(longest_valid_parentheses).
-export([longest_valid_parentheses/1]).

longest_valid_parentheses(S) ->
    longest_valid_parentheses(S, 0, 0, 0, 0).

longest_valid_parentheses([], L, R, Max, _) ->
    longest_valid_parentheses_rev(reverse(S), 0, 0, Max, 0);
longest_valid_parentheses([$( | T], L, R, Max, Start) ->
    longest_valid_parentheses(T, L + 1, R, Max, Start);
longest_valid_parentheses([$) | T], L, R, Max, Start) ->
    case L of
        L when L > R ->
            longest_valid_parentheses(T, L, R + 1, Max, Start);
        L when L == R ->
            Len = (L + R) - Start;
            longest_valid_parentheses(T, 0, 0, max(Max, Len), 0);
        _ ->
            longest_valid_parentheses(T, 0, 0, Max, 0)
    end.

longest_valid_parentheses_rev([], L, R, Max, _) ->
    Max;
longest_valid_parentheses_rev([$( | T], L, R, Max, Start) ->
    case R of
        R when R > L ->
            longest_valid_parentheses_rev(T, L + 1, R, Max, Start);
        R when L == R ->
            Len = (L + R) - Start;
            longest_valid_parentheses_rev(T, 0, 0, max(Max, Len), 0);
        _ ->
            longest_valid_parentheses_rev(T, 0, 0, Max, 0)
    end;
longest_valid_parentheses_rev([$) | T], L, R, Max, Start) ->
    longest_valid_parentheses_rev(T, L, R + 1, Max, Start).

reverse(L) ->
    reverse(L, []).

reverse([], Acc) ->
    Acc;
reverse([H | T], Acc) ->
    reverse(T, [H | Acc]).