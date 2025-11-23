-module(symmetric_integers).
-export([countSymmetricIntegers/2]).

countSymmetricIntegers(Low, High) ->
  lists:foldl(fun(I, Acc) ->
                  case is_symmetric(I) of
                    true ->
                      Acc + 1;
                    false ->
                      Acc
                  end
              end, 0, lists:seq(Low, High)).

is_symmetric(Num) ->
  Str = integer_to_list(Num),
  Len = length(Str),
  case Len rem 2 of
    0 ->
      Half = Len div 2,
      FirstHalf = lists:sublist(Str, 1, Half),
      SecondHalfReversed = lists:reverse(lists:sublist(Str, Half + 1, Half)),
      FirstHalf =:= SecondHalfReversed;
    1 ->
      false
  end.