-module(solution).
-export([num_of_pairs/1]).

num_of_pairs([{Nums, Target}]) ->
  num_of_pairs(Nums, Target).

num_of_pairs(Nums, Target) ->
  num_of_pairs(Nums, Target, 0).

num_of_pairs([], _, Count) ->
  Count;
num_of_pairs([H | T], Target, Count) ->
  NewCount = num_of_pairs(H, Target, Nums, T, Count),
  num_of_pairs(T, Target, NewCount).

num_of_pairs(_, _, [], _, Count) ->
  Count;
num_of_pairs(Num1, Target, [Num2 | Rest], Nums, Count) ->
  case Num1 ++ Num2 =:= Target of
    true ->
      case Num2 ++ Num1 =:= Target of
        true when Num1 =/= Num2 ->
          num_of_pairs(Num1, Target, Rest, Nums, Count + 1);
        true when Num1 =:= Num2 ->
          num_of_pairs(Num1, Target, Rest, Nums, Count);
        false ->
          num_of_pairs(Num1, Target, Rest, Nums, Count)
      end;
    false ->
      case Num2 ++ Num1 =:= Target of
        true ->
          num_of_pairs(Num1, Target, Rest, Nums, Count + 1);
        false ->
          num_of_pairs(Num1, Target, Rest, Nums, Count)
      end
  end.