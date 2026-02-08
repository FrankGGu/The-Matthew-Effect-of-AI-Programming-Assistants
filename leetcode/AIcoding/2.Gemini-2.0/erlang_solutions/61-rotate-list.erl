-module(rotate_list).
-export([rotate_right/2]).

rotate_right(List, K) ->
  Len = length(List),
  if Len == 0 ->
    List;
  true ->
    RealK = K rem Len,
    if RealK == 0 ->
      List;
    true ->
      {Part1, Part2} = lists:split(Len - RealK, List),
      Part2 ++ Part1
    end
  end.