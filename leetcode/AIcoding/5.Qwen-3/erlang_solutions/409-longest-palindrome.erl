-module(longest_palindrome).
-export([longest_palindrome/1]).

longest_palindrome(S) ->
    longest_palindrome(S, 0, 0, 0, 0).

longest_palindrome(_, MaxLen, Start, _, _) when MaxLen == erlang:length(S) ->
    substring(S, Start, MaxLen);
longest_palindrome(S, MaxLen, Start, Left, Right) ->
    case erlang:element(1, erlang:split(Right, S)) of
        {L, R} ->
            case is_palindrome(L, R) of
                true ->
                    Len = erlang:length(L) + erlang:length(R),
                    if
                        Len > MaxLen ->
                            longest_palindrome(S, Len, Left, Left - 1, Right + 1);
                        true ->
                            longest_palindrome(S, MaxLen, Start, Left - 1, Right + 1)
                    end;
                false ->
                    longest_palindrome(S, MaxLen, Start, Left - 1, Right + 1)
            end;
        _ ->
            longest_palindrome(S, MaxLen, Start, Left - 1, Right + 1)
    end.

is_palindrome([], []) -> true;
is_palindrome([H|T], [H|R]) -> is_palindrome(T, R);
is_palindrome(_, _) -> false.

substring(S, Start, Length) ->
    erlang:list_to_binary(erlang:sublist(S, Start + 1, Length)).