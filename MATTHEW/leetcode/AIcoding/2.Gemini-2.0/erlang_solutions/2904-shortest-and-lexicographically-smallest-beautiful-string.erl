-module(shortest_beautiful_string).
-export([shortest_beautiful_string/2]).

shortest_beautiful_string(S, K) ->
  Len = length(S),
  {BestLen, BestStr} = find_shortest(S, K, Len, infinity, ""),
  if BestLen =:= infinity then
    ""
  else
    BestStr
  end.

find_shortest(S, K, Len, BestLen, BestStr) ->
  find_shortest_helper(S, K, Len, 0, BestLen, BestStr).

find_shortest_helper(S, K, Len, Start, BestLen, BestStr) ->
  if Start >= Len then
    {BestLen, BestStr}
  else
    find_shortest_window(S, K, Len, Start, Start, 0, BestLen, BestStr)
  end.

find_shortest_window(S, K, Len, Start, End, Count, BestLen, BestStr) ->
  if End >= Len then
    find_shortest_helper(S, K, Len, Start + 1, BestLen, BestStr)
  else
    Char = list_to_integer(string:substr(S, End + 1, 1)),
    NewCount = Count + Char,
    if NewCount =:= K then
      WindowLen = End - Start + 1,
      WindowStr = string:substr(S, Start + 1, WindowLen),
      if WindowLen < BestLen then
        find_shortest_helper(S, K, Len, Start + 1, WindowLen, WindowStr)
      elseif WindowLen =:= BestLen andalso WindowStr < BestStr then
        find_shortest_helper(S, K, Len, Start + 1, WindowLen, WindowStr)
      else
        find_shortest_helper(S, K, Len, Start + 1, BestLen, BestStr)
      end
    elseif NewCount < K then
      find_shortest_window(S, K, Len, Start, End + 1, NewCount, BestLen, BestStr)
    else
      find_shortest_helper(S, K, Len, Start + 1, BestLen, BestStr)
    end
  end.