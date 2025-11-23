-module(self_crossing).
-export([is_self_crossing/1]).

is_self_crossing(Distance) ->
  is_self_crossing(Distance, []).

is_self_crossing([], _) ->
  false;
is_self_crossing([A, B, C | Rest], Path) ->
  case A >= C and B <= list_to_integer(lists:nth(1, Path)) of
    true -> true;
    false ->
      case length(Path) >= 3 of
        true ->
          D = list_to_integer(lists:nth(3,Path)),
          case A =:= C + D and B =:= list_to_integer(lists:nth(1, Path)) - list_to_integer(lists:nth(2,Path)) of
            true -> true;
            false ->
              case length(Path) >= 4 of
                true ->
                    E = list_to_integer(lists:nth(4, Path)),
                    case A + E >= C and A <= C + E and B + list_to_integer(lists:nth(2, Path)) >= list_to_integer(lists:nth(4, Path)) and B <= list_to_integer(lists:nth(1, Path)) of
                      true -> true;
                      false -> is_self_crossing(Rest, [integer_to_list(A),integer_to_list(B)|Path])
                    end;
                false -> is_self_crossing(Rest, [integer_to_list(A),integer_to_list(B)|Path])
              end
          end
      end
  end;
is_self_crossing([A,B], Path) ->
  false;
is_self_crossing([A], Path) ->
  false.