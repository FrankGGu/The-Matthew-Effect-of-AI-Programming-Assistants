-module(count_square_sum_triples).
-export([count_triples/1]).

count_triples(N) ->
  count_triples(N, 0).

count_triples(N, Count) when N < 5 ->
  Count;
count_triples(N, Count) ->
  count_triples(N, Count, 1, 2).

count_triples(N, Count, A, B) when A > N ->
  Count;
count_triples(N, Count, A, B) when B > N ->
  count_triples(N, Count, A + 1, A + 2);
count_triples(N, Count, A, B) ->
  ASq = A * A,
  BSq = B * B,
  CSq = ASq + BSq,
  C = math:sqrt(CSq),
  if
    C == trunc(C) andalso C =< N ->
      count_triples(N, Count + 2, A, B + 1);
    true ->
      count_triples(N, Count, A, B + 1)
  end.