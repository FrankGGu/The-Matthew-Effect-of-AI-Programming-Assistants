-module(count_substrings2).
-export([num_of_substrings/2]).

num_of_substrings(S, T) ->
  num_of_substrings(S, T, length(S), length(T)).

num_of_substrings(S, T, LenS, LenT) ->
  count_substrings(string:to_list(S), string:to_list(T), LenS, LenT, 0).

count_substrings([], _, _, _, Acc) ->
  Acc;
count_substrings(_S, [], _, _, Acc) ->
  Acc;
count_substrings(S, T, LenS, LenT, Acc) ->
  count_substrings(tl(S), T, LenS, LenT, Acc + count_valid_substrings(S, T, LenT)).

count_valid_substrings(S, T, LenT) ->
  count_valid_substrings(S, T, LenT, 0, 0).

count_valid_substrings([], _, _, Count, Acc) ->
  Acc;
count_valid_substrings(S, T, LenT, Count, Acc) when Count >= LenT ->
  Acc;
count_valid_substrings(S, T, LenT, Count, Acc) ->
  Sub = lists:sublist(S, Count + 1),
  case is_valid(Sub, T) of
    true ->
      count_valid_substrings(S, T, LenT, Count + 1, Acc + 1);
    false ->
      count_valid_substrings(S, T, LenT, Count + 1, Acc)
  end.

is_valid(Sub, T) ->
  MapSub = maps:from_list(lists:map(fun(X) -> {X, lists:foldl(fun(Y, A) -> case X == Y of true -> A + 1; false -> A end end, 0, Sub)} end, lists:usort(Sub))),
  MapT = maps:from_list(lists:map(fun(X) -> {X, lists:foldl(fun(Y, A) -> case X == Y of true -> A + 1; false -> A end end, 0, T)} end, lists:usort(T))),

  lists:all(fun(X) -> 
                case maps:is_key(X, MapSub) of
                  true -> maps:get(X, MapSub) >= maps:get(X, MapT);
                  false -> false
                end
            end, lists:usort(T)).