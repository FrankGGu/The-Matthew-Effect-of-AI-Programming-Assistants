-module(solution).
-export([max_two_events/1]).

max_two_events(Events) ->
  lists:foldl(
    fun({Start, Value}, Acc) ->
      lists:foldl(
        fun({OtherStart, OtherValue}, InnerAcc) ->
          case is_overlapping({Start, OtherStart}) of
            true ->
              InnerAcc;
            false ->
              max(InnerAcc, Value + OtherValue)
          end
        end,
        Acc,
        Events
      )
    end,
    0,
    Events
  ).

is_overlapping({Start1, End1}, {Start2, End2}) ->
  (Start1 =< Start2 andalso End1 >= Start2) or
  (Start2 =< Start1 andalso End2 >= Start1).