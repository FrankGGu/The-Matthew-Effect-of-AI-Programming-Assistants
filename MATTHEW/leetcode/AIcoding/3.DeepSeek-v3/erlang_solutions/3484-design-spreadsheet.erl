-module(excel).
-export([init/1, set/3, get/2, sum/3]).

init(Size) ->
    dict:new().

set(Row, Col, Val, Sheet) ->
    dict:store({Row, Col}, Val, Sheet).

get(Row, Col, Sheet) ->
    case dict:find({Row, Col}, Sheet) of
        {ok, Val} -> Val;
        error -> 0
    end.

sum(R1, C1, R2, C2, Sheet) ->
    Sum = lists:sum([get(R, C, Sheet) || R <- lists:seq(R1, R2), C <- lists:seq(C1, C2)]),
    Sum.