-module(solution).
-export([find132pattern/1]).

find132pattern(Nums) ->
  find132pattern(Nums, [], -infinity).

find132pattern([], Stack, _) ->
  false;
find132pattern([Num | Rest], Stack, K) ->
  case
    Num > K ->
      case
        Stack of
          [] ->
            find132pattern(Rest, [Num], K);
          _ ->
            {NewStack, NewK} = pop_smaller(Stack, Num, K),
            find132pattern(Rest, [Num | NewStack], NewK)
        end;
    Num < K ->
      true;
    true ->
      find132pattern(Rest, Stack, K)
  end.

pop_smaller(Stack, Num, K) ->
  case
    Stack of
      [] ->
        {[], K};
      [Top | Rest] ->
        case
          Top < Num ->
            pop_smaller(Rest, Num, Top);
          true ->
            {[Top | Rest], K}
        end
  end.