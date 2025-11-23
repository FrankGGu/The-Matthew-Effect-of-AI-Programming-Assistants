-module(my_calendar_i).
-export([new/0, book/2]).

new() -> [].

book(Calendar, Start, End) ->
  case check_overlap(Calendar, Start, End) of
    true ->
      {false, Calendar};
    false ->
      {true, lists:insert(find_insertion_point(Calendar, Start), Calendar, {Start, End})}
  end.

check_overlap([], _Start, _End) ->
  false;
check_overlap([{ExistingStart, ExistingEnd} | Rest], Start, End) ->
  case overlap(ExistingStart, ExistingEnd, Start, End) of
    true ->
      true;
    false ->
      check_overlap(Rest, Start, End)
  end.

overlap(ExistingStart, ExistingEnd, Start, End) ->
  Start < ExistingEnd andalso End > ExistingStart.

find_insertion_point([], _Start) ->
  1;
find_insertion_point([{ExistingStart, _} | Rest], Start) ->
  case Start < ExistingStart of
    true ->
      1;
    false ->
      1 + find_insertion_point(Rest, Start)
  end.