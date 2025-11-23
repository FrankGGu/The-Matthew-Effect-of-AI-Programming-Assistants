-module(solution).
-export([are_almost_equal/2]).

are_almost_equal(S, T) ->
    are_almost_equal(S, T, 0).

are_almost_equal([], [], _Count) ->
    true;
are_almost_equal([H|T1], [H|T2], Count) ->
    are_almost_equal(T1, T2, Count);
are_almost_equal([H1|T1], [H2|T2], Count) when H1 /= H2 ->
    if
        Count == 0 ->
            are_almost_equal(T1, T2, 1);
        true ->
            false
    end;
are_almost_equal(_, _, _) ->
    false.