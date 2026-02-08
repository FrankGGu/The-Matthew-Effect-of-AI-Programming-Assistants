-module(isomorphic_strings).
-export([is_isomorphic/2]).

is_isomorphic(S, T) ->
  isomorphic(S, T, [], []).

isomorphic([], [], _, _) ->
  true;
isomorphic([H1 | T1], [H2 | T2], Map1, Map2) ->
  case lists:keyfind(H1, 1, Map1) of
    false ->
      case lists:keyfind(H2, 1, Map2) of
        false ->
          isomorphic(T1, T2, [{H1, H2} | Map1], [{H2, H1} | Map2]);
        {H2, _} ->
          false
      end;
    {H1, V1} ->
      V1 == H2 andalso isomorphic(T1, T2, Map1, Map2)
  end;
isomorphic(_, _, _, _) ->
  false.