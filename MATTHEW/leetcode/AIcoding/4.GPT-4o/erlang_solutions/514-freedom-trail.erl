-module(solution).
-export([find_rotate_steps/2]).

%% This function finds the minimum steps to spell the key from the ring.
-spec find_rotate_steps(Ring :: unicode:unicode_binary(), Key :: unicode:unicode_binary()) -> integer().
find_rotate_steps(Ring, Key) ->
    %% Create a map to store the positions of each character in the ring.
    CharPositions = build_char_positions(Ring),
    %% Call the recursive helper function to calculate minimum steps.
    find_steps(CharPositions, Ring, Key, 0, 0, 0).

%% This helper function builds a map where each character points to its positions in the ring.
build_char_positions(Ring) ->
    build_char_positions(Ring, [], #{}).

build_char_positions([], Acc, Acc).
build_char_positions([H | T], Acc, Map) ->
    UpdatedMap = case maps:find(H, Map) of
        {ok, Indices} -> maps:put(H, [length(Indices) | Indices], Map);
        error -> maps:put(H, [0], Map)
    end,
    build_char_positions(T, [H | Acc], UpdatedMap).

%% This function recursively computes the minimum steps to spell all characters in the key.
find_steps(_, _, [], _PrevPos, Steps, _) -> 
    Steps;
find_steps(CharPositions, Ring, [KeyChar | Rest], PrevPos, Steps, LastCharIndex) ->
    %% Find the positions of the current key character in the ring.
    Positions = maps:get(KeyChar, CharPositions),
    %% Calculate the minimum steps to rotate and spell the current character.
    MinSteps = lists:foldl(fun(Pos, Min) ->
                               RotationSteps = min_rotation_steps(Ring, PrevPos, Pos),
                               NewSteps = RotationSteps + Steps + 1,
                               min(Min, NewSteps)
                           end, 1000, Positions),
    %% Recursively process the next character.
    find_steps(CharPositions, Ring, Rest, LastCharIndex, MinSteps, KeyChar).

%% This function calculates the minimum rotation steps between two positions on the ring.
min_rotation_steps(Ring, FromPos, ToPos) ->
    RingLen = length(Ring),
    CW = abs(ToPos - FromPos),
    CCW = RingLen - CW,
    min(CW, CCW).
