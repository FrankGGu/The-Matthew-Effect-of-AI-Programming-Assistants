-module(append_characters).
-export([solve/2]).

solve(S, T) ->
  solve(S, T, 0, 0).

solve(S, T, S_Index, T_Index) ->
  case {S_Index >= length(S), T_Index >= length(T)} of
    {true, true} -> 0;
    {true, false} -> length(T) - T_Index;
    {false, true} -> 0;
    {false, false} ->
      if
        list_to_integer(string:slice(S, S_Index, 1)) =:= list_to_integer(string:slice(T, T_Index, 1)) ->
          solve(S, T, S_Index + 1, T_Index + 1);
        true ->
          solve(S, T, S_Index + 1, T_Index)
      end
  end.