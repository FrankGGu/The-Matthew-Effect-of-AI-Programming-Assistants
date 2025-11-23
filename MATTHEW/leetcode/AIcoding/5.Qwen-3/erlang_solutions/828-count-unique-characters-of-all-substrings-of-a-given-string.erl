-module(solution).
-export([num_unique_substrings/1]).

num_unique_substrings(S) ->
    num_unique_substrings(S, 0, 0, 0, []).

num_unique_substrings([], _, _, _, _) -> 0;
num_unique_substrings([C | T], Index, Count, Last, Seen) ->
    NewLast = case lists:keyfind(C, 1, Seen) of
                  false -> Last;
                  {_, Val} -> Val
              end,
    NewCount = Count + (Index - NewLast),
    NewSeen = lists:keystore(C, 1, Seen, {C, Index}),
    num_unique_substrings(T, Index + 1, Count + (Index - NewLast), NewLast, NewSeen).