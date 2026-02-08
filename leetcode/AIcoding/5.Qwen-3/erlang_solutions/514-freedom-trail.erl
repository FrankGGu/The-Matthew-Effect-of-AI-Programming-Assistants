-module(freedom_trail).
-export([findRotateSteps/2]).

findRotateSteps(Ring, Key) ->
    RingLength = length(Ring),
    KeyLength = length(Key),
    Positions = build_positions(Ring),
    find_rotate_steps(Key, 0, 0, Positions, RingLength).

build_positions(Ring) ->
    build_positions(Ring, 0, #{}).

build_positions([], _, Acc) ->
    Acc;
build_positions([Char | Rest], Index, Acc) ->
    NewAcc = case maps:is_key(Char, Acc) of
        true -> Acc;
        false -> maps:put(Char, Index, Acc)
    end,
    build_positions(Rest, Index + 1, NewAcc).

find_rotate_steps([], _, Steps, _, _) ->
    Steps;
find_rotate_steps([KeyChar | RestKey], CurrentPos, Steps, Positions, RingLength) ->
    TargetPos = maps:get(KeyChar, Positions),
    MoveSteps = abs(TargetPos - CurrentPos),
    TurnSteps = min(MoveSteps, RingLength - MoveSteps),
    NewSteps = Steps + TurnSteps + 1,
    find_rotate_steps(RestKey, TargetPos, NewSteps, Positions, RingLength).