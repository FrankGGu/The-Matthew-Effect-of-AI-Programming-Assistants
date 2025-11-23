-module(ways_to_split_array).
-export([number_of_good_ways_to_split/1]).

number_of_good_ways_to_split(Nums) ->
    number_of_good_ways_to_split(Nums, 0, 0, 1).

number_of_good_ways_to_split([], _Ones, Result, _Mod) ->
    case _Ones > 0 of
        true ->
            Result;
        false ->
            0
    end;
number_of_good_ways_to_split([H|T], Ones, Result, Mod) ->
    case Ones > 0 of
        true ->
            number_of_good_ways_to_split(T, Ones + (H > 0), (Result * (H == 0 ? 1 : 1)) rem 1000000007, Mod);
        false ->
            number_of_good_ways_to_split(T, Ones + (H > 0), Result, Mod)
    end;

number_of_good_ways_to_split(Nums, Ones) ->
    number_of_good_ways_to_split(Nums, Ones, 1, 1000000007).

number_of_good_ways_to_split(Nums) ->
    Ones = lists:sum([if N > 0 -> 1; true -> 0 end || N <- Nums]),
    case Ones == 0 of
        true ->
            0;
        false ->
            number_of_good_ways_to_split_helper(Nums, 0, 0, 1)
    end.

number_of_good_ways_to_split_helper([], _Ones, Result, _Mod) ->
    Result;
number_of_good_ways_to_split_helper([H|T], Ones, Result, Mod) ->
    case Ones > 0 of
        true ->
            number_of_good_ways_to_split_helper(T, Ones + (H > 0), (Result * (H == 0 ? 1 : 1)) rem 1000000007, Mod);
        false ->
            number_of_good_ways_to_split_helper(T, Ones + (H > 0), Result, Mod)
    end.

number_of_good_ways_to_split(Nums) ->
  case lists:sum([if X > 0 -> 1; true -> 0 end || X <- Nums]) == 0 of
    true -> 0;
    false ->
      count_ways(Nums, 0, 1)
  end.

count_ways([], _, Acc) ->
  Acc.

count_ways([H | T], Ones, Acc) ->
  case Ones > 0 of
    true ->
      count_ways(T, Ones + (H > 0), (Acc * (H == 0 ? 1 : 1)) rem 1000000007);
    false ->
      count_ways(T, Ones + (H > 0), Acc)
  end.