-module(verify_postorder).
-export([verify_postorder/1]).

verify_postorder(Postorder) ->
  verify_postorder(Postorder, -infinity, infinity).

verify_postorder([], _, _) ->
  true;
verify_postorder([H|T], Min, Max) ->
  case H < Min or H > Max of
    true ->
      false;
    false ->
      {Left, Right} = lists:partition(fun(X) -> X < H end, T),
      verify_postorder(Left, Min, H) and verify_postorder(Right, H, Max)
  end.