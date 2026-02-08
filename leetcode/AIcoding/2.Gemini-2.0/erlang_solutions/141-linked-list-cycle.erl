-module(linked_list_cycle).
-export([hasCycle/1]).

hasCycle(Head) ->
  hasCycle(Head, Head).

hasCycle(Slow, Fast) ->
  case Fast of
    null ->
      false;
    _ ->
      case Fast#list_node.next of
        null ->
          false;
        NextFast ->
          case NextFast#list_node.next of
            null ->
              false;
            NextNextFast ->
              case Slow =:= NextFast of
                true ->
                  true;
                false ->
                  hasCycle(Slow#list_node.next, NextNextFast)
              end
          end
      end
  end.