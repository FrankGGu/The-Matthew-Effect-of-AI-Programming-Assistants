-module(solution).
-export([unhappyFriends/3]).

unhappyFriends(N, preferences, pairs) ->
    Friends = lists:seq(0, N - 1),
    P = maps:from_list([{X, lists:seq(0, N - 1)} || X <- Friends]),
    Pref = lists:zip(Friends, preferences),
    Pairs = lists:zip(Friends, pairs),
    Unhappy = lists:foldl(fun({A, B}, Acc) ->
        case unhappy(A, B, Pref, Pairs) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Pairs),
    Unhappy.

unhappy(A, B, Pref, Pairs) ->
    {C, D} = lists:keyfind(A, 1, Pairs),
    list_to_integer(lists:index(A, lists:keyfind(C, 1, Pairs))) < list_to_integer(lists:index(B, lists:keyfind(D, 1, Pairs))) orelse
    list_to_integer(lists:index(B, lists:keyfind(C, 1, Pairs))) < list_to_integer(lists:index(A, lists:keyfind(D, 1, Pairs))).