-module(solution).
-export([can_jump/2]).

can_jump(Start, A) ->
    can_jump_helper(Start, A, maps:from_list([{Start, true}]), []).

can_jump_helper(Index, A, Visited, _) when Index < 0; Index >= length(A) ->
    false;
can_jump_helper(Index, A, Visited, Path) when maps:is_key(Index, Visited) ->
    maps:get(Index, Visited);
can_jump_helper(Index, A, Visited, Path) ->
    NewPath = [Index | Path],
    JumpForward = Index + lists:nth(Index + 1, A),
    JumpBackward = Index - lists:nth(Index + 1, A),
    NewVisited = maps:put(Index, true, Visited),
    can_jump_helper(JumpForward, A, NewVisited, NewPath) orelse 
    can_jump_helper(JumpBackward, A, NewVisited, NewPath).