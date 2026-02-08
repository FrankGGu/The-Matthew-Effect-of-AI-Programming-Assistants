-module(magical_string).
-export([magical_string/1]).

magical_string(N) ->
  magical_string_helper(N, [1, 2, 2], [1], 3, 3, 1).

magical_string_helper(N, S, Counts, I, J, OneCount) when J > N ->
  OneCount;
magical_string_helper(N, S, Counts, I, J, OneCount) ->
  Count = lists:nth(I, Counts),
  NewS = lists:concat([S, lists:duplicate(Count, next_num(lists:last(S)))]),
  NewCounts = Counts,
  NewOneCount = OneCount + lists:sum([if X == 1 -> 1; true -> 0 end || X <- lists:duplicate(Count, next_num(lists:last(S)))]),
  magical_string_helper(N, NewS, [NewCounts, Count], I + 1, J + Count, NewOneCount).

next_num(1) -> 2;
next_num(2) -> 1.