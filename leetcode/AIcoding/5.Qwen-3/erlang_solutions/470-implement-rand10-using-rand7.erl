-module(rand10).
-export([rand10/0]).

rand10() ->
    N = rand7() * 7 + rand7(),
    if
        N =< 40 -> N rem 10 + 1;
        true -> rand10()
    end.

rand7() ->
    rand:uniform(7).