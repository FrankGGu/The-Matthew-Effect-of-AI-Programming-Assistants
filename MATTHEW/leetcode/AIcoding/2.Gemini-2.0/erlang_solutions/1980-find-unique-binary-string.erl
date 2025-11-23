-module(unique_binary_string).
-export([find_different_binary_string/1]).

find_different_binary_string(Nums) ->
  N = length(Nums),
  find_different_binary_string_helper(Nums, N, 0).

find_different_binary_string_helper(Nums, N, Index) ->
  case Index < N of
    true ->
      case lists:member(list_to_binary([bit(Num, Index) || Num <- Nums]), [list_to_binary(integer_to_list(I, 2)) || I <- lists:seq(0, math:pow(2, N) - 1)]) of
        true ->
          find_different_binary_string_helper(Nums, N, Index + 1);
        false ->

          lists:flatten([integer_to_list(I, 2) || I <- lists:seq(0, math:pow(2, N) - 1), not lists:member(list_to_binary(integer_to_list(I, 2)), [list_to_binary(Num) || Num <- Nums])])[0]
      end;
    false ->

      lists:flatten([integer_to_list(I, 2) || I <- lists:seq(0, math:pow(2, N) - 1), not lists:member(list_to_binary(integer_to_list(I, 2)), [list_to_binary(Num) || Num <- Nums])])[0]
  end.

bit(Num, Index) ->
  case Num of
    [H|T] ->

       try
        list_to_integer([lists:nth(Index+1, Num)])
       catch
           _:_ ->
           0
       end;
    _ ->

      0
  end.