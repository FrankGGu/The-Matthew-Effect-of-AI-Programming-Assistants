-module(dota2_senate).
-export([predict_party_victory/1]).

predict_party_victory(senate) ->
  predict_party_victory(string:to_list(senate), 0, 0).

predict_party_victory([], R, D) ->
  case {R, D} of
    {0, _} -> "Radiant";
    {_, 0} -> "Dire";
    {_, _} ->
      if R > D -> "Radiant"
      else "Dire"
      end
  end;

predict_party_victory(Senate, R, D) ->
  {NewSenate, NewR, NewD} = ban(Senate, R, D, []),
  predict_party_victory(NewSenate, NewR, NewD).

ban([H|T], R, D, Acc) ->
  case H of
    $R ->
      if D > 0 then
        {[T], R + 1, D - 1}
      else
        {[T, $R], R + 1, D}
      end;
    $D ->
      if R > 0 then
        {[T], R - 1, D + 1}
      else
        {[T, $D], R, D + 1}
      end
  end.