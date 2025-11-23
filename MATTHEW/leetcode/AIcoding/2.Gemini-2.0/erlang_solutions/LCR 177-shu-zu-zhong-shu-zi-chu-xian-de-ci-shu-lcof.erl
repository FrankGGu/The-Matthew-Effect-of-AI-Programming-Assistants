-module(colorful_outfit).
-export([solve/1]).

solve(Colors) ->
  solve(Colors, []).

solve([], Acc) ->
  length(Acc);
solve([H|T], Acc) ->
  solve(T, lists:foldl(fun(Color, Acc1) ->
                                  case (H =/= Color) andalso (not lists:member({H, Color}, Acc1)) andalso (not lists:member({Color, H}, Acc1)) of
                                    true -> [{H, Color}|Acc1];
                                    false -> Acc1
                                  end
                              end, Acc, lists:usort(T))).