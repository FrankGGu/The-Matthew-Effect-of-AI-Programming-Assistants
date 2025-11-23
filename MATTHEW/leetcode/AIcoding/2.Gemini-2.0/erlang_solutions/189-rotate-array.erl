-module(rotate_array).
-export([rotate/2]).

rotate(Nums, K) ->
  Len = length(Nums),
  Kmod = K rem Len,
  if Kmod == 0 ->
    Nums
  else
    {Left, Right} = lists:split(Len - Kmod, Nums),
    Right ++ Left
  end.