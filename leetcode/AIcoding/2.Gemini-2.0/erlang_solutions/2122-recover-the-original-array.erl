-module(recover_array).
-export([recover_array/1]).

recover_array(Nums) ->
  recover_array_helper(lists:sort(Nums), []).

recover_array_helper([], Acc) ->
  Acc;
recover_array_helper(Nums, Acc) ->
  First = lists:nth(1, Nums),
  case find_k(Nums, First) of
    {ok, K, NewNums} ->
      recover_array_helper(NewNums, Acc ++ [K]);
    error ->
      []
  end.

find_k(Nums, First) ->
  Len = length(Nums),
  find_k_helper(Nums, First, 1, Len).

find_k_helper(Nums, First, I, Len) when I =< Len ->
  Second = lists:nth(I, Nums),
  K = (Second - First) div 2,
  if (Second - First) rem 2 == 0 andalso K > 0 then
    case check_valid(Nums, First, K) of
      {ok, NewNums} ->
        {ok, K, NewNums};
      error ->
        find_k_helper(Nums, First, I + 1, Len)
    end
  else
    find_k_helper(Nums, First, I + 1, Len)
  end;
find_k_helper(_, _, _, _) ->
  error.

check_valid(Nums, First, K) ->
  check_valid_helper(Nums, First, K, []).

check_valid_helper(Nums, First, K, Used) ->
  case find_match(Nums, First + K, Used) of
    {ok, Index} ->
      Second = lists:nth(Index, Nums),
      case find_match(Nums, Second - K, Used ++ [Index]) of
        {ok, Index2} ->
          check_valid_helper(Nums, First, K, Used ++ [Index, Index2]);
        error ->
          error
      end;
    error ->
      if length(Nums) - length(Used) == 0 then
        NewNums = remove_used(Nums, Used),
        {ok, NewNums}
      else
        error
      end
  end.

find_match(Nums, Target, Used) ->
  find_match_helper(Nums, Target, Used, 1, length(Nums)).

find_match_helper(Nums, Target, Used, I, Len) when I =< Len ->
  case lists:member(I, Used) of
    true ->
      find_match_helper(Nums, Target, Used, I + 1, Len);
    false ->
      if lists:nth(I, Nums) == Target then
        {ok, I}
      else
        find_match_helper(Nums, Target, Used, I + 1, Len)
      end
  end;
find_match_helper(_, _, _, _, _) ->
  error.

remove_used(Nums, Used) ->
  remove_used_helper(Nums, Used, []).

remove_used_helper([], _, Acc) ->
  lists:reverse(Acc);
remove_used_helper([H|T], Used, Acc) ->
  case find_index(H, T ++ [H], Used, 1) of
    0 ->
      remove_used_helper(T, Used, [H|Acc]);
    _ ->
      remove_used_helper(T, Used, Acc)
  end.

find_index(_, [], _, _) -> 0;
find_index(Val, [H|T], Used, Index) ->
  case lists:member(Index, Used) of
    true ->
      find_index(Val, T, Used, Index + 1);
    false ->
      if H == Val then
        Index
      else
        find_index(Val, T, Used, Index + 1)
      end
  end.