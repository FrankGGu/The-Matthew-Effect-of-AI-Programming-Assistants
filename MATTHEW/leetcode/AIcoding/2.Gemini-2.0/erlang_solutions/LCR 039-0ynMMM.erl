-module(largest_rectangle_in_histogram).
-export([largest_rectangle_area/1]).

largest_rectangle_area(Heights) ->
    largest_rectangle_area(Heights, []).

largest_rectangle_area([], Stack) ->
    largest_rectangle_area_helper([], Stack, 0);
largest_rectangle_area([H|T], Stack) ->
    largest_rectangle_area([H|T], Stack, 0).

largest_rectangle_area([H|T], Stack, MaxArea) ->
    case Stack of
        [] ->
            largest_rectangle_area(T, [{H, 0}|Stack], MaxArea);
        [{SH, SI}|_] ->
            if
                H < SH ->
                    {Area, NewStack} = pop_stack(H, Stack, 0),
                    largest_rectangle_area([H|T], NewStack, max(MaxArea, Area));
                true ->
                    largest_rectangle_area(T, [{H, length(Stack)}|Stack], MaxArea)
            end
    end.

pop_stack(H, Stack, Area) ->
    case Stack of
        [] ->
            {Area, []};
        [{SH, SI}|Rest] ->
            NewArea = SH * (length(Stack) - SI),
            if
                H < SH ->
                    pop_stack(H, Rest, max(Area, NewArea));
                true ->
                    {Area, Stack}
            end
    end.

largest_rectangle_area_helper([], Stack, MaxArea) ->
    largest_rectangle_area_helper(Stack, MaxArea);
largest_rectangle_area_helper(Stack, MaxArea) ->
    case Stack of
        [] ->
            MaxArea;
        [{SH, SI}|Rest] ->
            NewArea = SH * (length(Stack) - SI),
            largest_rectangle_area_helper(Rest, max(MaxArea, NewArea))
    end.