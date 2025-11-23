-module(max_sum_two_non_overlapping).
-export([max_sum_two_no_overlap/3]).

max_sum_two_no_overlap(A, L, M) ->
  N = length(A),
  lists:max([find_max(A, N, L, M), find_max(A, N, M, L)]).

find_max(A, N, FirstLen, SecondLen) ->
  prefix_sums(A, N, FirstLen, SecondLen, 0, 0, 0).

prefix_sums(A, N, FirstLen, SecondLen, I, MaxFirst, Result) ->
  if
    I + FirstLen + SecondLen > N ->
      Result;
    true ->
      FirstSum = lists:sum(lists:sublist(A, I + 1, FirstLen)),
      MaxFirstNew = max(MaxFirst, FirstSum),
      SecondSum = lists:sum(lists:sublist(A, I + FirstLen + 1, SecondLen)),
      prefix_sums(A, N, FirstLen, SecondLen, I + 1, MaxFirstNew, max(Result, MaxFirstNew + SecondSum))
  end.

max(A, B) ->
  if A > B -> A;
  true -> B
  end.