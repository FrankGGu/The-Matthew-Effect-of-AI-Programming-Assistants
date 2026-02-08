-module(additive_number).
-export([isAdditiveNumber/1]).

isAdditiveNumber(Num) ->
  isAdditiveNumber(string:to_list(Num)).

isAdditiveNumber(NumList) ->
  Len = length(NumList),
  lists:any(fun(Len1) ->
                lists:any(fun(Len2) ->
                              Len1 + Len2 < Len andalso
                                checkAdditive(NumList, Len1, Len2)
                          end, lists:seq(1, Len - Len1 -1))
            end, lists:seq(1, Len - 2)).

checkAdditive(NumList, Len1, Len2) ->
  Num1Str = lists:sublist(NumList, 1, Len1),
  Num2Str = lists:sublist(NumList, Len1 + 1, Len2),
  case {isLeadingZero(Num1Str), isLeadingZero(Num2Str)} of
    {true, _} ->
      false;
    {_, true} ->
      false;
    {false, false} ->
      Num1 = list_to_integer(Num1Str),
      Num2 = list_to_integer(Num2Str),
      checkAdditiveHelper(NumList, Len1 + Len2 + 1, Num1, Num2)
  end.

checkAdditiveHelper(NumList, Start, Num1, Num2) ->
  case nextAdditive(NumList, Start, Num1, Num2) of
    {ok, Sum, NewStart} ->
      checkAdditiveHelper(NumList, NewStart, Num2, Sum);
    error ->
      Start > length(NumList) + 1
  end.

nextAdditive(NumList, Start, Num1, Num2) ->
  Sum = Num1 + Num2,
  SumStr = integer_to_list(Sum),
  SumLen = length(SumStr),
  End = Start + SumLen - 1,

  if End > length(NumList) then
    error
  else
    SubList = lists:sublist(NumList, Start, SumLen),
    if SubList =:= SumStr then
      case isLeadingZero(SubList) of
          true when SumLen > 1 -> error;
          _ -> {ok, Sum, End + 1}
      end

    else
      error
    end
  end.

isLeadingZero(Str) ->
  case Str of
    [] -> false;
    [H|_] -> H == $0
  end.