-module(solution).
-export([find_length_of_lcis/1]).

find_length_of_lcis([]) -> 0;
find_length_of_lcis([_]) -> 1;
find_length_of_lcis(Nums) ->
    lcis_helper(tl(Nums), hd(Nums), 1, 1).

lcis_helper([], _Prev, MaxLen, _CurrentLen) ->
    MaxLen;
lcis_helper([H|T], Prev, MaxLen, CurrentLen) when H > Prev ->
    NewCurrentLen = CurrentLen + 1,
    NewMaxLen = max(MaxLen, NewCurrentLen),
    lcis_helper(T, H, NewMaxLen, NewCurrentLen);
lcis_helper([H|T], _Prev, MaxLen, _CurrentLen) when H =< _Prev ->
    lcis_helper(T, H, MaxLen, 1).