-module(degree_of_array).
-export([find_shortest_subarray/1]).

find_shortest_subarray(Nums) ->
  {Counts, FirstOccurrences, LastOccurrences} = process_nums(Nums, #{}, #{}, #{}, 0),
  Degree = get_degree(Counts),
  find_shortest_length(Nums, Degree, FirstOccurrences, LastOccurrences).

process_nums([], Counts, FirstOccurrences, LastOccurrences, _) ->
  {Counts, FirstOccurrences, LastOccurrences};
process_nums([Num | Rest], Counts, FirstOccurrences, LastOccurrences, Index) ->
  NewCounts = maps:update_with(Num, fun(C) -> C + 1 end, 1, Counts),
  NewFirstOccurrences = 
    case maps:is_key(Num, FirstOccurrences) of
      true -> FirstOccurrences;
      false -> maps:put(Num, Index, FirstOccurrences)
    end,
  NewLastOccurrences = maps:put(Num, Index, LastOccurrences),
  process_nums(Rest, NewCounts, NewFirstOccurrences, NewLastOccurrences, Index + 1).

get_degree(Counts) ->
  lists:max([V || {_, V} <- maps:to_list(Counts)]).

find_shortest_length(Nums, Degree, FirstOccurrences, LastOccurrences) ->
  RelevantNums = [Num || {Num, Count} <- maps:to_list(process_nums(Nums, #{}, #{}, #{}, 0) #1), Count == Degree],
  lists:foldl(fun(Num, Acc) ->
                  First = maps:get(Num, FirstOccurrences),
                  Last = maps:get(Num, LastOccurrences),
                  Len = Last - First + 1,
                  min(Acc, Len)
              end, length(Nums), RelevantNums).