-module(count_elements_with_maximum_frequency).
-export([solve/1]).

solve(Nums) ->
  {Frequencies, _} = lists:foldl(
    fun(Num, {Acc, MaxFreq}) ->
      case maps:is_key(Num, Acc) of
        true ->
          NewFreq = maps:get(Num, Acc) + 1;
          NewAcc = maps:put(Num, Acc, NewFreq);
          NewMaxFreq = max(MaxFreq, NewFreq);
          {NewAcc, NewMaxFreq};
        false ->
          NewAcc = maps:put(Num, Acc, 1);
          NewMaxFreq = max(MaxFreq, 1);
          {NewAcc, NewMaxFreq}
      end
    end,
    {#{}, 0},
    Nums
  ),
  lists:foldl(
    fun(Num, Acc) ->
      case maps:get(Num, Frequencies) of
        Freq when Freq == lists:max(maps:values(Frequencies)) ->
          Acc + 1;
        _ ->
          Acc
      end
    end,
    0,
    Nums
  ).