-module(number_of_ways).
-export([number_of_ways/3]).

number_of_ways(StartPos, EndPos, K) ->
  number_of_ways_memo(StartPos, EndPos, K, #{}).

number_of_ways_memo(StartPos, EndPos, 0, Memo) ->
  case StartPos == EndPos of
    true -> 1;
    false -> 0
  end;
number_of_ways_memo(StartPos, EndPos, K, Memo) ->
  case maps:get({StartPos, K}, Memo, undefined) of
    undefined ->
      Left = number_of_ways_memo(StartPos - 1, EndPos, K - 1, Memo);
      Right = number_of_ways_memo(StartPos + 1, EndPos, K - 1, Memo);
      Result = Left + Right;
      NewMemo = maps:put({StartPos, K}, Result, Memo);
      Result;
    Value ->
      Value
  end.