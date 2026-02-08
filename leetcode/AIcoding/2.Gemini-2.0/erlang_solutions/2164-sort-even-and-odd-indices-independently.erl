-module(sort_even_odd).
-export([sort_even_odd/1]).

sort_even_odd(Nums) ->
  {Evens, Odds} = lists:foldl(
    fun(N, {Es, Os}) ->
      Index = length(Es) + length(Os);
      if Index rem 2 == 0 then
        {[N | Es], Os}
      else
        {Es, [N | Os]}
      end
    end,
    {[], []},
    Nums
  ),
  SortedEvens = lists:sort(Evens),
  SortedOdds = lists:reverse(lists:sort(Odds)),
  lists:zipwith(
    fun(E, O) ->
      [E, O]
    end,
    SortedEvens,
    SortedOdds
  ) ++ lists:sublist(SortedEvens, length(SortedOdds) + 1, length(SortedEvens) - length(SortedOdds)).