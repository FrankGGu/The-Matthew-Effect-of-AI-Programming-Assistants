-module(minimum_garbage_collection).
-export([garbage_collection/2]).

garbage_collection(Garbage, Travel) ->
  garbage_collection(Garbage, Travel, 0, 0, 0, 0, 0).

garbage_collection([], _, M, P, G, Ml, Pl, Gl) ->
  Ml + Pl + Gl + M + P + G;
garbage_collection([H|T], Travel, M, P, G, Ml, Pl, Gl) ->
  NewM = string:str(H, "M") > 0,
  NewP = string:str(H, "P") > 0,
  NewG = string:str(H, "G") > 0,
  NewMl = if NewM == true -> length(Travel) else Ml end,
  NewPl = if NewP == true -> length(Travel) else Pl end,
  NewGl = if NewG == true -> length(Travel) else Gl end,
  NewMCount = M + string:len(lists:flatten([string:tokens(H, "MPG") -- ["P", "G"]])),
  NewPCount = P + string:len(lists:flatten([string:tokens(H, "MPG") -- ["M", "G"]])),
  NewGCount = G + string:len(lists:flatten([string:tokens(H, "MPG") -- ["M", "P"]])),
  garbage_collection(T, tl(Travel), NewMCount, NewPCount, NewGCount, NewMl, NewPl, NewGl).

tl([]) -> [].
tl(L) -> tl_helper(L, []).

tl_helper([], Acc) ->
  lists:reverse(Acc);
tl_helper([_|T], Acc) ->
  tl_helper(T, Acc).