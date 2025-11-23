-module(super_ugly_number).
-export([nthSuperUglyNumber/2]).

nthSuperUglyNumber(N, Primes) ->
  nthSuperUglyNumber(N, Primes, [1], lists:duplicate(length(Primes), 0)).

nthSuperUglyNumber(1, _, UglyNumbers, _) ->
  lists:nth(1, UglyNumbers);
nthSuperUglyNumber(N, Primes, UglyNumbers, Pointers) ->
  NextUgly = findNextUgly(Primes, UglyNumbers, Pointers),
  {NewUglyNumbers, NewPointers} = updateUglyNumbersAndPointers(NextUgly, Primes, UglyNumbers, Pointers),
  nthSuperUglyNumber(N - 1, Primes, NewUglyNumbers, NewPointers).

findNextUgly(Primes, UglyNumbers, Pointers) ->
  lists:foldl(
    fun(Index, {MinUgly, MinIndex}) ->
      Prime = lists:nth(Index + 1, Primes),
      Ugly = lists:nth(lists:nth(Index + 1, Pointers) + 1, UglyNumbers) * Prime,
      if
        Ugly < MinUgly -> {Ugly, Index};
        true -> {MinUgly, MinIndex}
      end
    end,
    {math:pow(2, 31), -1},
    lists:seq(0, length(Primes) - 1)
  ).

updateUglyNumbersAndPointers(NextUgly, Primes, UglyNumbers, Pointers) ->
  NewUglyNumbers = UglyNumbers ++ [NextUgly],
  NewPointers = updatePointers(NextUgly, Primes, UglyNumbers, Pointers, 0),
  {NewUglyNumbers, NewPointers}.

updatePointers(NextUgly, Primes, UglyNumbers, Pointers, Index) ->
  case Index < length(Primes) of
    true ->
      Prime = lists:nth(Index + 1, Primes),
      if
        lists:nth(lists:nth(Index + 1, Pointers) + 1, UglyNumbers) * Prime == NextUgly ->
          NewPointers = lists:nth(Index + 1, Pointers) + 1,
          updatePointers(NextUgly, Primes, UglyNumbers, lists:nth(Index + 1, Pointers, Pointers, [NewPointers]), Index + 1);
        true ->
          updatePointers(NextUgly, Primes, UglyNumbers, Pointers, Index + 1)
      end;
    false ->
      Pointers
  end,
  NewPointersList = lists:zip(lists:seq(1, length(Primes)), Pointers),
  NewPointersList2 = lists:foldl(
    fun({I, _}, Acc) ->
      Prime = lists:nth(I, Primes),
      if lists:nth(lists:nth(I, Pointers) + 1, UglyNumbers) * Prime == NextUgly ->
        lists:nth(I, Pointers, Acc, [lists:nth(I, Pointers) + 1]);
      true ->
        Acc
      end
    end,
    Pointers,
    lists:zip(lists:seq(1, length(Primes)), Pointers)
  ),
  NewPointersList2.