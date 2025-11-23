-module(jump_game).
-export([can_reach/2]).

can_reach(Jumps, Target) ->
    can_reach(Jumps, Target, 0, sets:new()).

can_reach(_, _, Index, _) when Index >= length(Jumps) ->
    Index == Target;
can_reach(_, _, Index, Visited) when sets:is_element(Index, Visited) ->
    false;
can_reach(Jumps, Target, Index, Visited) ->
    NextVisited = sets:add_element(Index, Visited),
    Jump = lists:nth(Index + 1, Jumps),
    case Index + Jump of
        NewIndex when NewIndex < length(Jumps) ->
            can_reach(Jumps, Target, NewIndex, NextVisited);
        _ ->
            can_reach(Jumps, Target, Index + 1, NextVisited)
    end.