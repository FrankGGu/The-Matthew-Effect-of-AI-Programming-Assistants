-module(solution).
-export([rand10/0]).

rand10() ->
    rand:seed(exsplus),
    rand10_helper().

rand10_helper() ->
    Row = rand:uniform(7) - 1,
    Col = rand:uniform(7) - 1,
    Idx = Row * 7 + Col,
    if
        Idx < 40 -> (Idx rem 10) + 1;
        true -> rand10_helper()
    end.