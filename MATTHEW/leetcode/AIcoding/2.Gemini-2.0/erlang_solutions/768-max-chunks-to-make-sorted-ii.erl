-module(max_chunks_to_make_sorted_ii).
-export([max_chunks_to_sorted/1]).

max_chunks_to_sorted(Arr) ->
  N = length(Arr),
  RightMin = lists:foldr(fun(X, Acc) -> [min(X, hd(Acc))] ++ Acc end, [1000000001], Arr),
  LeftMax = lists:foldl(fun(X, Acc) -> Acc ++ [max(X, case lists:reverse(Acc) of [] -> -1000000001; L -> hd(L) end)] end, [], Arr),
  max_chunks_to_sorted_helper(LeftMax, tl(RightMin), 0).

max_chunks_to_sorted_helper([H1|T1], [H2|T2], Count) ->
  if H1 =< H2 then
    max_chunks_to_sorted_helper(T1, T2, Count + 1)
  else
    if T1 == [] then
      Count + 1
    else
      max_chunks_to_sorted_helper(T1, T2, Count)
    end
  end;
max_chunks_to_sorted_helper([], [], Count) ->
  Count.