-module(solution).
-export([maximumCostSubstring/3]).

maximumCostSubstring(S, Chars, Vals) ->
    InitialCharCostsArray = array:new([{size, 26}, {fixed, true}]),
    InitializedArray = initialize_char_costs_array(0, InitialCharCostsArray),
    UpdatedCharCostsArray = update_char_costs_array(Chars, Vals, InitializedArray),
    kadane_array(S, UpdatedCharCostsArray, 0, 0).

initialize_char_costs_array(26, Array) ->
    Array;
initialize_char_costs_array(Index, Array) ->
    Value = Index + 1,
    NewArray = array:set(Index, Value, Array),
    initialize_char_costs_array(Index + 1, NewArray).

update_char_costs_array([], [], AccArray) ->
    AccArray;
update_char_costs_array([Char | RestChars], [Val | RestVals], AccArray) ->
    Index = Char - $a,
    NewAccArray = array:set(Index, Val, AccArray),
    update_char_costs_array(RestChars, RestVals, NewAccArray).

kadane_array([], _CharCostsArray, MaxSoFar, _CurrentMax) ->
    MaxSoFar;
kadane_array([Char | RestS], CharCostsArray, MaxSoFar, CurrentMax) ->
    Index = Char - $a,
    CharCost = array:get(Index, CharCostsArray),
    NewCurrentMax = CurrentMax + CharCost,
    UpdatedMaxSoFar = max(MaxSoFar, NewCurrentMax),
    UpdatedCurrentMax = max(0, NewCurrentMax),
    kadane_array(RestS, CharCostsArray, UpdatedMaxSoFar, UpdatedCurrentMax).