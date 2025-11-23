-module(strict_palindromic).
-export([is_strictly_palindromic/1]).

to_base(N, Base) ->
    to_base(N, Base, []).

to_base(0, _, Acc) ->
    lists:reverse(Acc);
to_base(N, Base, Acc) ->
    to_base(N div Base, Base, [N rem Base | Acc]).

is_palindrome(List) ->
    List =:= lists:reverse(List).

is_strictly_palindromic(N) ->
    case N < 4 of
        true ->
            false;
        false ->
            lists:all(fun(Base) ->
                              NumInBase = to_base(N, Base),
                              is_palindrome(NumInBase)
                      end, lists:seq(2, N - 2))
    end.