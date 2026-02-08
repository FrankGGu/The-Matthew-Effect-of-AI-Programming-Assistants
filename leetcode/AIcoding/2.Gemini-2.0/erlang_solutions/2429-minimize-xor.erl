-module(minimize_xor).
-export([minimize_xor/2]).

minimize_xor(N, Num) ->
  BitN = erlang:integer_to_list(N, 2),
  BitNum = erlang:integer_to_list(Num, 2),
  LenN = length(BitN),
  LenNum = length(BitNum),

  SetBitsN = lists:sum([1 || X <- BitN, X =:= $1]),
  SetBitsNum = lists:sum([1 || X <- BitNum, X =:= $1]),

  if SetBitsN > SetBitsNum then
    Res = create_result(Num, SetBitsN - SetBitsNum, 1, LenNum),
    list_to_integer(Res, 2)
  else if SetBitsN < SetBitsNum then
    Res = create_result(Num, SetBitsNum - SetBitsN, 0, LenNum),
    list_to_integer(Res, 2)
  else
    Num
  end.

create_result(Num, Diff, Bit, Len) ->
  BitNum = erlang:integer_to_list(Num, 2),
  BitNumPadded = pad_with_zeros(BitNum, Len),

  lists:foldl(fun(X, Acc) ->
    case X of
      $1 ->
        if Bit =:= 0 then
          if Diff > 0 then
            Acc ++ [$0],
            Diff1 = Diff - 1
          else
            Acc ++ [X]
          end
        else
          Acc ++ [X]
        end;
      $0 ->
        if Bit =:= 1 then
          if Diff > 0 then
            Acc ++ [$1],
            Diff1 = Diff - 1
          else
            Acc ++ [X]
          end
        else
          Acc ++ [X]
        end
    end
  , [], BitNumPadded).

pad_with_zeros(List, Len) ->
  LenList = length(List),
  if LenList < Len then
    lists:duplicate(Len - LenList, $0) ++ List
  else
    List
  end.