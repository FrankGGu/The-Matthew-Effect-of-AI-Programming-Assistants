-module(solution).
-export([num_ways/1]).

num_ways(N) ->
  num_ways(N, [], []).

num_ways(0, _, _) -> 1;
num_ways(N, A, B) ->
  case N < 0 of
    true -> 0;
    false ->
      S1 = case lists:member(N, A) of
        true -> 0;
        false -> num_ways(N - 1, [N | A], B)
      end,
      S2 = case lists:member(N, B) of
        true -> 0;
        false -> num_ways(N - 2, A, [N | B])
      end,
      (S1 + S2) rem (1000000000 + 7)
  end.