-module(solution).
-export([checkIfDigitsAreEqual/1]).

checkIfDigitsAreEqual(S) ->
    check(S).

check([]) ->
    true;
check([H1, H2 | T]) ->
    H1 == H2 andalso check(T);
check(_) ->
    false.