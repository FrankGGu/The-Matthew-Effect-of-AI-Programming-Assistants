-module(avoid_flood).
-export([avoid_flood/1]).

avoid_flood(Rains) ->
    avoid_flood(Rains, dict:new(), [], []).

avoid_flood([], _, _, Result) ->
    Result;
avoid_flood([0 | T], Lakes, Pools, Result) ->
    avoid_flood(T, Lakes, [0 | Pools], Result);
avoid_flood([R | T], Lakes, Pools, Result) ->
    case dict:find(R, Lakes) of
        {ok, Index} ->
            case find_first_zero(Pools, Index) of
                -1 ->
                    [];
                Pos ->
                    NewPools = lists:substitute(Pos, R, Pools),
                    NewLakes = dict:store(R, length(Pools), Lakes),
                    avoid_flood(T, NewLakes, NewPools, [R | Result])
            end;
        error ->
            NewLakes = dict:store(R, length(Pools), Lakes),
            avoid_flood(T, NewLakes, Pools, [0 | Result])
    end.

find_first_zero([], _) ->
    -1;
find_first_zero([0 | _], Index) ->
    Index;
find_first_zero([_ | T], Index) ->
    find_first_zero(T, Index + 1).

lists:substitute(_, _, []) ->
    [];
lists:substitute(Index, Value, List) ->
    lists:sublist(List, Index) ++ [Value] ++ lists:sublist(List, Index + 1, length(List) - Index).