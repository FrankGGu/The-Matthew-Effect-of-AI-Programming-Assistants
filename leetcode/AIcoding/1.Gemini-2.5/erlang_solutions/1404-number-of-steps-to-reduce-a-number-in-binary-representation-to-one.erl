-module(solution).
-export([num_steps/1]).

num_steps(S) ->
    case S of
        "1" -> 0;
        _ -> num_steps_rev_str(lists:reverse(S), 0)
    end.

num_steps_rev_str([$1], Steps) ->
    Steps;
num_steps_rev_str([$0 | T], Steps) ->
    num_steps_rev_str(T, Steps + 1);
num_steps_rev_str([$1 | T], Steps) ->
    NewS_rev = add_one_rev([$1 | T]),
    num_steps_rev_str(NewS_rev, Steps + 1).

add_one_rev(S_rev) ->
    add_one_recursive_rev(S_rev, [], 1).

add_one_recursive_rev([], Acc, 0) ->
    Acc;
add_one_recursive_rev([], Acc, 1) ->
    [$1 | Acc];
add_one_recursive_rev([$0 | T], Acc, 0) ->
    add_one_recursive_rev(T, [$0 | Acc], 0);
add_one_recursive_rev([$1 | T], Acc, 0) ->
    add_one_recursive_rev(T, [$1 | Acc], 0);
add_one_recursive_rev([$0 | T], Acc, 1) ->
    add_one_recursive_rev(T, [$1 | Acc], 0);
add_one_recursive_rev([$1 | T], Acc, 1) ->
    add_one_recursive_rev(T, [$0 | Acc], 1).