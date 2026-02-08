-module(temperature_trends).
-export([temperature_trend/2]).

temperature_trend(PreviousTemperatures, CurrentTemperatures) ->
  temperature_trend(PreviousTemperatures, CurrentTemperatures, 0, 0).

temperature_trend([], [], Acc, Count) ->
  case Count of
    0 -> 0;
    _ -> Acc div Count
  end;

temperature_trend([Prev | PrevRest], [Curr | CurrRest], Acc, Count) ->
  case {Curr > Prev, Curr < Prev, Curr == Prev} of
    {true, false, false} ->
      temperature_trend(PrevRest, CurrRest, Acc + 1, Count + 1);
    {false, true, false} ->
      temperature_trend(PrevRest, CurrRest, Acc - 1, Count + 1);
    {false, false, true} ->
      temperature_trend(PrevRest, CurrRest, Acc, Count + 1);
    _ ->
      temperature_trend(PrevRest, CurrRest, Acc, Count)
  end.