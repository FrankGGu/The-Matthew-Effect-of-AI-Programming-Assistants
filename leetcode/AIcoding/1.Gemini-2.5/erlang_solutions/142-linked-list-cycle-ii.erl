-module(solution).
-export([detectCycle/1]).

-record(list_node, {val, next}).

detectCycle(Head) ->
    if Head == nil or Head#list_node.next == nil ->
        nil;
    true ->
        MeetingPoint = find_meeting_point_internal(Head, Head),
        if MeetingPoint == nil ->
            nil;
        true ->
            find_cycle_start(Head, MeetingPoint)
        end
    end.

find_meeting_point_internal(Slow, Fast) ->
    case Fast of
        nil ->
            nil;
        #list_node{next = nil} ->
            nil;
        _ ->
            SlowNext = Slow#list_node.next,
            FastNext = Fast#list_node.next#list_node.next,
            if SlowNext == FastNext ->
                SlowNext;
            true ->
                find_meeting_point_internal(SlowNext, FastNext)
            end
    end.

find_cycle_start(Ptr1, Ptr2) ->
    if Ptr1 == Ptr2 ->
        Ptr1;
    true ->
        find_cycle_start(Ptr1#list_node.next, Ptr2#list_node.next)
    end.