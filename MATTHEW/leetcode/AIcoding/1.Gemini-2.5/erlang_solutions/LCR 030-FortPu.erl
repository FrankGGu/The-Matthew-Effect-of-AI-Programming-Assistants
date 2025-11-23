-module(randomized_set).

-export([new/0, insert/2, remove/2, get_random/1]).

new() ->
    %% For competitive programming, rand:seed/1 might be needed.
    %% LeetCode environments often handle random seeding or use a fixed seed.
    %% rand:seed(os:timestamp()),
    {maps:new(), array:new(), 0}.

insert(Val, {Map, Arr, Size}) ->
    case maps:is_key(Val, Map) of
        true ->
            {false, {Map, Arr, Size}};
        false ->
            NewMap = maps:put(Val, Size, Map),
            NewArr = array:set(Size, Val, Arr),
            NewSize = Size + 1,
            {true, {NewMap, NewArr, NewSize}}
    end.

remove(Val, {Map, Arr, Size}) ->
    case maps:is_key(Val, Map) of
        false ->
            {false, {Map, Arr, Size}};
        true ->
            IdxToRemove = maps:get(Val, Map),
            LastIdx = Size - 1,
            NewSize = Size - 1,

            NewMap1 = maps:remove(Val, Map),

            case IdxToRemove == LastIdx of
                true ->
                    %% The value to remove is the last element in the array.
                    %% Just remove it from the map and decrement the size.
                    %% The array itself doesn't need physical modification
                    %% as the element is no longer part of the logical set.
                    {true, {NewMap1, Arr, NewSize}};
                false ->
                    %% The value to remove is not the last element.
                    %% Swap it with the last element.
                    LastVal = array:get(LastIdx, Arr),
                    NewArr = array:set(IdxToRemove, LastVal, Arr),
                    NewMap = maps:put(LastVal, IdxToRemove, NewMap1), %% Update LastVal's index in map
                    {true, {NewMap, NewArr, NewSize}}
            end
    end.

get_random({_Map, _Arr, 0}) ->
    undefined; %% Or an error, depending on problem spec for empty set
get_random({_Map, Arr, Size}) ->
    %% rand:uniform(N) returns an integer in the range 1..N.
    %% Array indices are 0..N-1, so we subtract 1.
    RandIdx = rand:uniform(Size) - 1,
    array:get(RandIdx, Arr).