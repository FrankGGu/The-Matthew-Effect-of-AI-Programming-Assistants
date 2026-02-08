-module(smallestString).
-export([smallestLexicalOrder/2]).

smallestLexicalOrder(S, A, B) ->
  Len = length(S),
  Visited = sets:new(),
  Queue = queue:new(),
  queue:in({S, 0}, Queue),
  sets:add_element(S, Visited),
  smallestLexicalOrderHelper(A, B, Len, Visited, Queue, S).

smallestLexicalOrderHelper(A, B, Len, Visited, Queue, CurrentSmallest) ->
  case queue:is_empty(Queue) of
    true ->
      CurrentSmallest;
    false ->
      {Value, NewQueue} = queue:out(Queue),
      {S, Depth} = Value,

      Add = lists:map(fun(C) ->
                            (C - $0 + A) rem 10 + $0
                        end, S),
      AddStr = list_to_binary(Add),

      case sets:is_element(AddStr, Visited) of
        true ->
          smallestLexicalOrderHelper(A, B, Len, Visited, NewQueue, CurrentSmallest);
        false ->
          Visited2 = sets:add_element(AddStr, Visited),
          NewSmallest1 = min(CurrentSmallest, AddStr),
          Queue2 = queue:in({AddStr, Depth + 1}, NewQueue),

          Swap =
            if B rem 2 == 0 then
              []
            else
              NewS = lists:nthtail(1, S) ++ [lists:nth(1, S)],
              [NewS]
            end,

          case Swap of
            [] ->
              smallestLexicalOrderHelper(A, B, Len, Visited2, Queue2, NewSmallest1);
            [NewS] ->
              SwapStr = list_to_binary(NewS),
              case sets:is_element(SwapStr, Visited2) of
                true ->
                  smallestLexicalOrderHelper(A, B, Len, Visited2, Queue2, NewSmallest1);
                false ->
                  Visited3 = sets:add_element(SwapStr, Visited2),
                  NewSmallest2 = min(NewSmallest1, SwapStr),
                  Queue3 = queue:in({SwapStr, Depth + 1}, Queue2),
                  smallestLexicalOrderHelper(A, B, Len, Visited3, Queue3, NewSmallest2)
              end
          end
      end
  end.