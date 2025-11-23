-module(number_of_ways).
-export([num_of_ways/1]).

num_of_ways(S) ->
  S_list = string:to_list(S),
  Len = length(S_list),
  Memo = dict:new(),
  num_of_ways_helper(S_list, 0, Memo, Len) rem 1000000007.

num_of_ways_helper(_S, Index, _Memo, Len) when Index >= Len ->
  1;
num_of_ways_helper(S, Index, Memo, Len) ->
  case dict:find( {Index}, Memo) of
    {ok, Value} ->
      Value;
    error ->
      Result = num_of_ways_helper_calc(S, Index, Memo, Len),
      NewMemo = dict:store( {Index}, Result, Memo),
      Result
  end.

num_of_ways_helper_calc(S, Index, Memo, Len) ->
  Sum = lists:foldl(
    fun(Length, Acc) ->
      if Index + Length > Len then
        Acc
      else
        SubStr = lists:sublist(S, Index + 1, Length),
        case string:to_integer(list_to_binary(SubStr)) of
          {IntVal, _} ->
            if SubStr =/= [ $0 ] andalso is_valid(S, Index, Length) then
              (Acc + num_of_ways_helper(S, Index + Length, Memo, Len)) rem 1000000007
            else
              Acc
            end;
          error ->
            Acc
        end
      end
    end,
    0,
    lists:seq(1, Len)
  ),
  Sum.

is_valid(S, Index, Length) ->
  case Index of
    0 ->
      true;
    _ ->
      PrevLength = find_prev_length(S, Index),
      SubStr = lists:sublist(S, Index + 1, Length),
      PrevSubStr = lists:sublist(S, Index - PrevLength + 1, PrevLength),
      case {string:to_integer(list_to_binary(SubStr)), string:to_integer(list_to_binary(PrevSubStr))} of
        {{IntVal, _}, {PrevIntVal, _}} ->
          IntVal >= PrevIntVal;
        _ ->
          false
      end
  end.

find_prev_length(S, Index) ->
  lists:foldl(
    fun(Length, Acc) ->
      SubStr = lists:sublist(S, Index - Length + 1, Length),
      case string:to_integer(list_to_binary(SubStr)) of
        {_, _} ->
          Length;
        error ->
          Acc
      end
    end,
    0,
    lists:seq(1, Index)
  ).