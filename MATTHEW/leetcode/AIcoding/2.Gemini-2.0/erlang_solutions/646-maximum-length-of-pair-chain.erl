-module(max_length_chain).
-export([find_longest_chain/1]).

find_longest_chain(Pairs) ->
  find_longest_chain_helper(lists:sort(fun({A1, B1}, {A2, B2}) -> B1 < B2 end, Pairs), -infinity, 0).

find_longest_chain_helper([], _, Count) ->
  Count;
find_longest_chain_helper([{A, B} | Rest], PrevEnd, Count) ->
  case A > PrevEnd of
    true ->
      find_longest_chain_helper(Rest, B, Count + 1);
    false ->
      find_longest_chain_helper(Rest, PrevEnd, Count)
  end.