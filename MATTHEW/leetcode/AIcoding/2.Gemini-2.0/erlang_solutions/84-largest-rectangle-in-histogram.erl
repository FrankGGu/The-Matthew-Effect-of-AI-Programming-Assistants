-module(largestRectangleArea).
-export([largestRectangleArea/1]).

largestRectangleArea(Heights) ->
  largestRectangleArea(Heights, []).

largestRectangleArea([], Stack) ->
  largestRectangleArea_helper([], Stack, 0);
largestRectangleArea([H|T], Stack) ->
  largestRectangleArea([H|T], Stack, 0, 0);

largestRectangleArea([H|T], Stack, Acc, Index) ->
  case Stack of
    [] ->
      largestRectangleArea(T, [{H, Index}]), Acc;
    [{TopH, TopIndex}|Rest] ->
      case H < TopH of
        true ->
          {NewStack, Area} = largestRectangleArea_helper([{H, Index}], Stack, 0),
          largestRectangleArea(T, NewStack, max(Acc, Area), 0);
        false ->
          largestRectangleArea(T, [{H, Index}|Stack], Acc, Index + 1)
      end
  end;
largestRectangleArea_helper(NewStack, Stack, Acc) ->
  case Stack of
    [] ->
      {NewStack, Acc};
    [{H, Index}|Rest] ->
      Area = H * (length(NewStack) + Index),
      largestRectangleArea_helper(NewStack, Rest, max(Acc, Area))
  end.