-module(find_number_of_possible_ways_for_an_event).
-export([number_of_ways/3]).

number_of_ways(startPos, endPos, k) ->
  memo_number_of_ways(startPos, endPos, k, #{}).

memo_number_of_ways(CurrentPos, EndPos, 0, Memo) ->
  case maps:get({CurrentPos, 0}, Memo, undefined) of
    undefined ->
      Result = case CurrentPos == EndPos of
                 true -> 1;
                 false -> 0
               end,
      maps:put({CurrentPos, 0}, Result, Memo)
    ;
    Result ->
      Result
  end;

memo_number_of_ways(CurrentPos, EndPos, Steps, Memo) ->
  case maps:get({CurrentPos, Steps}, Memo, undefined) of
    undefined ->
      LeftResult = memo_number_of_ways(CurrentPos - 1, EndPos, Steps - 1, Memo),
      RightResult = memo_number_of_ways(CurrentPos + 1, EndPos, Steps - 1, Memo),
      Result = (LeftResult + RightResult) rem 1000000007,
      maps:put({CurrentPos, Steps}, Result, Memo),
      Result;
    Result ->
      Result
  end.