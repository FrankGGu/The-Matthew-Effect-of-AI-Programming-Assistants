-module(linked_list_cycle_ii).
-export([detectCycle/1]).

detectCycle(Head) ->
  detectCycle_helper(Head).

detectCycle_helper(Head) ->
  case Head of
    null ->
      null;
    _ ->
      try_detect_cycle(Head).
  end.

try_detect_cycle(Head) ->
  try_detect_cycle_helper(Head, Head).

try_detect_cycle_helper(Slow, Fast) ->
  case Fast of
    null ->
      null;
    _ ->
      case Fast#node.next of
        null ->
          null;
        _ ->
          case Fast#node.next#node.next of
            null ->
              null;
            _ ->
              SlowNext = Slow#node.next,
              FastNext = Fast#node.next#node.next,
              if SlowNext == FastNext ->
                find_entry_point(Head, SlowNext);
              true ->
                try_detect_cycle_helper(SlowNext, FastNext)
              end
          end
      end
  end.

find_entry_point(Head, MeetingPoint) ->
  find_entry_point_helper(Head, MeetingPoint).

find_entry_point_helper(Ptr1, Ptr2) ->
  if Ptr1 == Ptr2 ->
    Ptr1;
  true ->
    find_entry_point_helper(Ptr1#node.next, Ptr2#node.next)
  end.