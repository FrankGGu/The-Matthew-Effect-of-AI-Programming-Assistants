-module(next_greater_element_iv).
-export([next_greater_elements/1]).

next_greater_elements(Nums) ->
  N = length(Nums),
  Result = lists:duplicate(N, -1),
  Stack1 = orddict:new(),
  Stack2 = orddict:new(),

  lists:foreach(
    fun(I) ->
      Num = lists:nth(I + 1, Nums),

      % Find the second greater element
      while not orddict:is_empty(Stack2) andalso Num > orddict:fetch(orddict:smallest(Stack2), Stack2) do
        {Index, _} = orddict:fetch(orddict:smallest(Stack2), Stack2),
        Result = lists:replace(Index + 1, lists:nth(Index + 1, Result), Num, Result),
        Stack2 = orddict:erase(orddict:smallest(Stack2), Stack2)
      end,

      % Find the first greater element
      while not orddict:is_empty(Stack1) andalso Num > orddict:fetch(orddict:smallest(Stack1), Stack1) do
        {Index, _} = orddict:fetch(orddict:smallest(Stack1), Stack1),
        Stack2 = orddict:store(Index, Num, Stack2),
        Stack1 = orddict:erase(orddict:smallest(Stack1), Stack1)
      end,

      % Push the current element into the stack
      Stack1 = orddict:store(I, Num, Stack1)
    end,
    lists:seq(0, N - 1)
  ),

  Result.