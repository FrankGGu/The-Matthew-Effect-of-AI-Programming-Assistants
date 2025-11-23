-module(jump_game_iii).
-export([can_reach/2]).

can_reach(Nums, Index) ->
    can_reach(Nums, Index, dict:new()).

can_reach(_, Index, Visited) when Index < 0 orelse Index >= length(Nums) ->
    false;
can_reach(Nums, Index, Visited) when dict:is_key(Index, Visited) ->
    false;
can_reach(Nums, Index, Visited) ->
    Value = lists:nth(Index + 1, Nums),
    case Value of
        0 ->
            true;
        _ ->
            NewVisited = dict:store(Index, true, Visited),
            Left = can_reach(Nums, Index - Value, NewVisited),
            Right = can_reach(Nums, Index + Value, NewVisited),
            Left orelse Right
    end.