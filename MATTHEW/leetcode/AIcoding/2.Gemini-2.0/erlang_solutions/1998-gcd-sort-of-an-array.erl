-module(gcd_sort).
-export([gcd_sort/1]).

gcd_sort(Nums) ->
  N = length(Nums),
  Parent = lists:seq(1, N),
  Size = lists:duplicate(N, 1),

  find(X, Parent) ->
    if X == lists:nth(X, Parent) then
      X
    else
      P = lists:nth(X, Parent),
      Root = find(P, Parent),
      lists:nth(X, Parent, Root)
    end.

  union(X, Y, Parent, Size) ->
    RootX = find(X, Parent),
    RootY = find(Y, Parent),
    if RootX == RootY then
      {Parent, Size}
    else
      {NewParent, NewSize} =
        case lists:nth(RootX, Size) < lists:nth(RootY, Size) of
          true ->
            NewParent1 = lists:nth(RootX, Parent, RootY),
            NewParent = lists:nth(RootY, Parent, NewParent1),
            NewSize1 = lists:nth(RootY, Size, lists:nth(RootY, Size) + lists:nth(RootX, Size)),
            NewSize = lists:nth(RootX, Size, NewSize1),
            {NewParent, NewSize};
          false ->
            NewParent1 = lists:nth(RootY, Parent, RootX),
            NewParent = lists:nth(RootX, Parent, NewParent1),
            NewSize1 = lists:nth(RootX, Size, lists:nth(RootX, Size) + lists:nth(RootY, Size)),
            NewSize = lists:nth(RootY, Size, NewSize1),
            {NewParent, NewSize}
        end,
      {NewParent, NewSize}
    end.

  gcd(A, 0) -> A;
  gcd(A, B) -> gcd(B, A rem B).

  max_val(Nums) ->
    lists:max(Nums).

  sieve(MaxVal) ->
    IsPrime = lists:duplicate(MaxVal + 1, true),
    lists:nth(0, IsPrime, false),
    lists:nth(1, IsPrime, false),
    for(2, MaxVal, IsPrime, MaxVal, []).

  for(P, MaxVal, IsPrime, OriginalMaxVal, Factors) ->
    if P * P > OriginalMaxVal then
      Factors
    else
      if lists:nth(P, IsPrime) then
        Factors1 = mark_multiples(P, P * P, MaxVal, IsPrime, Factors),
        for(P + 1, MaxVal, Factors1#state#is_prime, OriginalMaxVal, Factors1#state#factors)
      else
        for(P + 1, MaxVal, IsPrime, OriginalMaxVal, Factors)
      end
    end.

  mark_multiples(P, I, MaxVal, IsPrime, Factors) ->
    if I > MaxVal then
      #{state := #{factors := Factors, is_prime := IsPrime}}
    else
      NewIsPrime = lists:nth(I, IsPrime, false),
      mark_multiples(P, I + P, MaxVal, NewIsPrime, Factors)
    end.

  factors(N, Primes) ->
    find_factors(N, Primes, []).

  find_factors(1, _, Acc) ->
    Acc;
  find_factors(N, [P|Rest], Acc) ->
    if N rem P == 0 then
      find_factors(N div P, [P|Rest], [P|Acc])
    else
      find_factors(N, Rest, Acc)
    end.

  MaxVal = max_val(Nums),
  Primes = sieve(MaxVal),
  AllPrimes = [I || I <- lists:seq(2, MaxVal), lists:nth(I, Primes)],

  {NewParent, _NewSize} = lists:foldl(
    fun (I, {CurrentParent, CurrentSize}) ->
      Num = lists:nth(I + 1, Nums),
      PrimeFactors = lists:sort(lists:usort(factors(Num, AllPrimes))),
      lists:foldl(
        fun (Factor, {P, S}) ->
          Index = lists:keyfind(Factor, 2, [{Index1, Factor1} || Index1 <- lists:seq(1, length(Nums)), Factor1 <- PrimeFactors, Factor1 == Factor]),
          case Index of
            false ->
              {P, S};
            {Index2, _} ->
              union(I + 1, Index2, P, S)
          end
        end, {CurrentParent, CurrentSize}, PrimeFactors)
    end, {Parent, Size}, lists:seq(0, N - 1)),

  SortedNums = lists:sort(Nums),

  check_sortable(Nums, SortedNums, NewParent) ->
    lists:all(fun({A, B}) ->
                  RootA = find(lists:nth(1, A), NewParent),
                  RootB = find(lists:nth(1, B), NewParent),
                  RootA == RootB
              end, lists:zip(lists:enumerate(Nums), lists:enumerate(SortedNums))).

  check_sortable(Nums, SortedNums, NewParent).