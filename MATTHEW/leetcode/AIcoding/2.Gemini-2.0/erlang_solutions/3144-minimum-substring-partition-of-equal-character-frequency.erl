-module(min_substring_partition).
-export([min_substring_partition/1]).

min_substring_partition(S) ->
  Len = length(S),
  min_substring_partition_helper(S, 1, Len).

min_substring_partition_helper(_S, Count, 0) ->
  Count;
min_substring_partition_helper(S, Count, Len) ->
  lists:min([min_substring_partition_helper(lists:sublist(S, I + 1, Len - I), Count + 1, Len - I) || I <- lists:seq(1, Len - 1), is_equal_frequency(lists:sublist(S, 1, I))]).

is_equal_frequency(Sub) ->
  Frequencies = get_frequencies(Sub),
  case Frequencies of
    [] -> true;
    [First | Rest] ->
      lists:all(fun(Freq) -> Freq =:= First end, Rest)
  end.

get_frequencies(Sub) ->
  Counts = lists:foldl(fun(Char, Acc) ->
                          maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
                        end, #{}, Sub),
  maps:values(Counts).