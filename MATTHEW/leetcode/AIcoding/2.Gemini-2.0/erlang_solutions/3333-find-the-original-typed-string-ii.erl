-module(find_original_typed_string_ii).
-export([find_original_typed_string_ii/2]).

find_original_typed_string_ii(S, T) ->
  find_original_typed_string_ii(S, T, []).

find_original_typed_string_ii(S, T, Acc) ->
  find_original_typed_string_ii(S, T, Acc, 0, 0).

find_original_typed_string_ii(S, T, Acc, Si, Ti) ->
  case {Si >= length(S), Ti >= length(T)} of
    {true, true} ->
      lists:reverse(Acc);
    {true, false} ->
      [];
    {false, true} ->
      [];
    {false, false} ->
      case lists:nth(Si + 1, S) == lists:nth(Ti + 1, T) of
        true ->
          find_original_typed_string_ii(S, T, [lists:nth(Si + 1, S) | Acc], Si + 1, Ti + 1);
        false ->
          case (Ti + 1 < length(T) + 1) andalso (lists:nth(Ti + 1, T) == lists:nth(Ti + 2, T)) of
            true ->
              find_original_typed_string_ii(S, T, Acc, Si, Ti + 1);
            false ->
              []
          end
      end
  end.