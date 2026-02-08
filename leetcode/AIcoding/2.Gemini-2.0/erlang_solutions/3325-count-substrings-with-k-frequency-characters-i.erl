-module(count_substrings).
-export([count_substrings/2]).

count_substrings(S, K) ->
  count_substrings(S, K, 0).

count_substrings(S, K, Acc) ->
  Len = length(S),
  count_substrings(S, K, 0, Len, Acc).

count_substrings(_S, _K, I, Len, Acc) when I >= Len ->
  Acc;
count_substrings(S, K, I, Len, Acc) ->
  count_substrings(S, K, I, I + 1, Len, Acc).

count_substrings(_S, _K, I, J, Len, Acc) when J > Len ->
  Acc;
count_substrings(S, K, I, J, Len, Acc) ->
  Substr = string:sub_string(S, I + 1, J - I),
  case has_k_frequency(Substr, K) of
    true ->
      count_substrings(S, K, I, J + 1, Len, Acc + 1);
    false ->
      count_substrings(S, K, I, J + 1, Len, Acc)
  end.

has_k_frequency(S, K) ->
  Map = string_to_map(S),
  has_k_frequency(Map, K, 0).

has_k_frequency(Map, K, Count) ->
  case maps:is_key(K, Map) of
    true -> true;
    false ->
      case check_map_values(Map, K) of
        true -> true;
        false -> false
      end
  end.

check_map_values(Map, K) ->
  lists:any(fun(V) -> V =:= K end, maps:values(Map)).

string_to_map(S) ->
  string_to_map(S, #{}).

string_to_map([], Map) ->
  Map;
string_to_map([H|T], Map) ->
  case maps:is_key(H, Map) of
    true ->
      Val = maps:get(H, Map),
      string_to_map(T, maps:put(H, Val + 1, Map));
    false ->
      string_to_map(T, maps:put(H, 1, Map))
  end.