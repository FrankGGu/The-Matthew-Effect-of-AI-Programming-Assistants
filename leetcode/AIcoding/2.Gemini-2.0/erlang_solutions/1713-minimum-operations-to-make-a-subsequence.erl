-module(minimum_operations_to_make_subsequence).
-export([min_operations/2]).

min_operations(Target, Arr) ->
  Subsequence = longest_increasing_subsequence(Target, Arr),
  length(Target) - length(Subsequence).

longest_increasing_subsequence(Target, Arr) ->
  TailTable = lists:foldl(fun(Num, Acc) ->
                                  update_tail_table(Num, Acc, Target)
                          end, [], Arr),
  TailTable.

update_tail_table(Num, Acc, Target) ->
  case find_index(Num, Target) of
    none ->
      Acc;
    Index ->
      update_tail_table_helper(Index, Num, Acc)
  end.

find_index(Num, Target) ->
  find_index_helper(Num, Target, 1).

find_index_helper(_Num, [], _Index) ->
  none;
find_index_helper(Num, [H|T], Index) ->
  if H == Num ->
    Index;
  true ->
    case find_index_helper(Num, T, Index + 1) of
      none ->
        none;
      I ->
        I
    end
  end.

update_tail_table_helper(Index, Num, Acc) ->
  case lists:foldl(fun(X, {Found, Res, Count}) ->
                       if Found == true ->
                         {Found, [X|Res], Count + 1};
                       X >= Num ->
                         {true, [Num|Res], Count + 1};
                       true ->
                         {Found, [X|Res], Count + 1}
                     end
                   end, {false, [], 1}, Acc) of
    {false, _, 1} ->
      [Num | Acc];
    {true, Res, _} ->
      lists:reverse(Res)
  end.