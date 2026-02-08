-module(solution).
-export([find_target/2]).

find_target(Root, K) ->
    find_target_helper(Root, K, sets:new()).

find_target_helper(nil, _K, _Set) ->
    false;
find_target_helper({Val, Left, Right}, K, Set) ->
    Complement = K - Val,
    if sets:is_element(Complement, Set) ->
        true;
    true ->
        NewSet = sets:add_element(Val, Set),
        find_target_helper(Left, K, NewSet) orelse find_target_helper(Right, K, NewSet)
    end.