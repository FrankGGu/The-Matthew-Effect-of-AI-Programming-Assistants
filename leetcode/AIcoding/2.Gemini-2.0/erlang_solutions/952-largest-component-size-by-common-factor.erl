-module(largestComponentSize).
-export([largestComponentSize/1]).

largestComponentSize(A) ->
  N = length(A),
  MaxVal = lists:max(A),
  UF = uf_init(MaxVal + 1),

  lists:foreach(
    fun(Num) ->
      Factors = prime_factors(Num),
      lists:foreach(
        fun(Factor) ->
          union(UF, lists:nth(1, Factors), Factor)
        end,
        tl(Factors)
      )
    end,
    A
  ),

  Components = lists:map(fun(Num) -> find(UF, lists:nth(1, prime_factors(Num))) end, A),
  Counts = lists:foldl(
    fun(Component, Acc) ->
      maps:update_with(Component, fun(Count) -> Count + 1 end, 1, Acc)
    end,
    #{},
    Components
  ),
  case maps:is_empty(Counts) of
    true -> 0;
    false -> maps:get(lists:max(maps:values(Counts)), Counts, 0)
  end.

prime_factors(N) ->
  prime_factors_helper(N, 2, []).

prime_factors_helper(1, _, Acc) ->
  lists:reverse(Acc);
prime_factors_helper(N, I, Acc) when I * I > N ->
  lists:reverse([N | Acc]);
prime_factors_helper(N, I, Acc) when N rem I == 0 ->
  prime_factors_helper(N div I, I, [I | Acc]);
prime_factors_helper(N, I, Acc) ->
  prime_factors_helper(N, I + 1, Acc).

uf_init(N) ->
  {lists:seq(0, N - 1), lists:duplicate(N, 1)}.

find({Parents, _Sizes}, I) ->
  find_helper(Parents, I).

find_helper(Parents, I) ->
  case lists:nth(I+1, Parents) == I of
    true -> I;
    false ->
      Root = find_helper(Parents, lists:nth(I+1, Parents)),
      {Parents2, _} = lists:update(I+1, Root, Parents),
      Root
  end.

union({Parents, Sizes}, I, J) ->
  RootI = find({Parents, Sizes}, I),
  RootJ = find({Parents, Sizes}, J),
  case RootI == RootJ of
    true -> {Parents, Sizes};
    false ->
      SizeI = lists:nth(RootI+1, Sizes),
      SizeJ = lists:nth(RootJ+1, Sizes),
      case SizeI < SizeJ of
        true ->
          {Parents2, _} = lists:update(RootI+1, RootJ, Parents),
          {Sizes2, _} = lists:update(RootJ+1, SizeI + SizeJ, Sizes),
          {Parents2, Sizes2};
        false ->
          {Parents2, _} = lists:update(RootJ+1, RootI, Parents),
          {Sizes2, _} = lists:update(RootI+1, SizeI + SizeJ, Sizes),
          {Parents2, Sizes2}
      end
  end.