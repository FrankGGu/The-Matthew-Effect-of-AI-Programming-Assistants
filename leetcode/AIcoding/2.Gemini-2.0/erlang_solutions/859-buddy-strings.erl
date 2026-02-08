-module(buddy_strings).
-export([buddy_strings/2]).

buddy_strings(A, B) ->
  LenA = length(A),
  LenB = length(B),
  if LenA /= LenB ->
    false
  else
    case A =:= B of
      true ->
        lists:any(fun(C) -> lists:foldl(fun(X, Acc) -> if X =:= C -> Acc + 1 else Acc end, 0, A) >= 2 end, lists:seq($a, $z));
      false ->
        Diff = lists:zipwith(fun(X, Y) -> if X /= Y -> {X, Y} else undefined end, A, B),
        Filtered = lists:filter(fun(X) -> X /= undefined end, Diff),
        case length(Filtered) of
          2 ->
            [ {X1, Y1}, {X2, Y2} ] = Filtered,
            X1 =:= Y2 andalso X2 =:= Y1;
          _ ->
            false
        end
    end
  end.