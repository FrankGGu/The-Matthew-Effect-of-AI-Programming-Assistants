-module(largest_integer).
-export([largest_integer/2]).

largest_integer(Cost, Target) ->
  dp(Cost, Target).

dp(Cost, Target) ->
  Len = length(Cost),
  CostList = lists:zip(Cost, lists:seq(1, Len)),
  SortedCost = lists:sort(fun({C1, _}, {C2, _}) -> C1 =< C2 end, CostList),
  LenSorted = length(SortedCost),
  Memo = array:new([Target + 1], {invalid, ""}),

  array:set(0, {valid, ""}, Memo),

  lists:foreach(
    fun(T) ->
      lists:foreach(
        fun({C, I}) ->
          PrevT = T - C,
          case array:get(PrevT, Memo) of
            {valid, PrevNum} when PrevT >= 0 ->
              NewNum = PrevNum ++ integer_to_list(I),
              case array:get(T, Memo) of
                {valid, ExistingNum} ->
                  if
                    length(NewNum) > length(ExistingNum) ->
                      array:set(T, {valid, NewNum}, Memo);
                    length(NewNum) == length(ExistingNum) andalso NewNum > ExistingNum ->
                      array:set(T, {valid, NewNum}, Memo);
                    true ->
                      ok
                  end;
                {invalid, _} ->
                  array:set(T, {valid, NewNum}, Memo)
              end;
            _ ->
              ok
          end
        end,
        SortedCost
      )
    end,
    lists:seq(1, Target)
  ),

  case array:get(Target, Memo) of
    {valid, Num} ->
      SortedDigits = lists:sort(fun(A, B) -> A > B end, string:to_integer_list(Num)),
      list_to_integer(SortedDigits);
    _ ->
      "0"
  end.