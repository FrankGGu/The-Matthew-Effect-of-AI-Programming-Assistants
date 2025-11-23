-module(solution).
-export([longest_obstacle_course_at_each_position/1]).

longest_obstacle_course_at_each_position(HeightList) ->
    Length = length(HeightList),
    longest_obstacle(HeightList, Length, []).

longest_obstacle([], _, Acc) -> lists:reverse(Acc);
longest_obstacle([H | T], Length, Acc) ->
    NewAcc = case find_position(Acc, H) of
        {pos, Pos} -> lists:replace(Pos, H, Acc);
        {new, NewElem} -> Acc ++ [NewElem]
    end,
    longest_obstacle(T, Length, NewAcc).

find_position([], _) -> {new, 0};
find_position([H | T], X) when X >= H -> 
    {pos, length([H | T])};
find_position([H | T], X) -> find_position(T, X).