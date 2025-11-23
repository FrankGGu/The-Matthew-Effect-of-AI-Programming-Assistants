-module(solution).
-export([longest_obstacle_course/1]).

longest_obstacle_course(Obstacles) ->
    lists:reverse(longest_obstacle_course(Obstacles, [], [])).

longest_obstacle_course([], _, Result) ->
    Result;
longest_obstacle_course([H | T], Stack, Result) ->
    case find_index(Stack, H) of
        -1 ->
            longest_obstacle_course(T, [H | Stack], [1 | Result]);
        Index ->
            NewStack = lists:sublist(Stack, Index + 1) ++ [H],
            Length = Index + 2,
            longest_obstacle_course(T, NewStack, [Length | Result])
    end.

find_index([], _) ->
    -1;
find_index([H | T], Target) ->
    if
        H >= Target ->
            0;
        true ->
            case find_index(T, Target) of
                -1 -> -1;
                I -> I + 1
            end
    end.