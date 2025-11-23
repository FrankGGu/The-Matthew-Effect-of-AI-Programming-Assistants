-module(shortest_uncommon_substring).
-export([shortest_uncommon_substring/1]).

shortest_uncommon_substring(A) ->
  N = length(A),
  case N of
    0 -> "";
    _ ->
      case find_shortest_uncommon_substring(A) of
        undefined -> "";
        Substr -> Substr
      end
  end.

find_shortest_uncommon_substring(A) ->
  lists:foldl(
    fun(Len, Acc) ->
      case Acc of
        undefined ->
          case find_uncommon_substring_of_length(A, Len) of
            undefined ->
              undefined;
            Substr ->
              Substr
          end;
        Substr ->
          Substr
      end
    end,
    undefined,
    lists:seq(1, max_string_length(A))
  ).

find_uncommon_substring_of_length(A, Len) ->
  first_uncommon_substring(A, generate_substrings(lists:nth(1, A), Len)).

generate_substrings(Str, Len) ->
  generate_substrings_helper(Str, Len, []).

generate_substrings_helper(Str, Len, Acc) ->
  case string:len(Str) < Len of
    true ->
      lists:reverse(Acc);
    false ->
      Substr = string:sub_string(Str, 1, Len),
      generate_substrings_helper(string:substr(Str, 2), Len, [Substr | Acc])
  end.

first_uncommon_substring(A, Substrings) ->
  lists:foldl(
    fun(Substr, Acc) ->
      case Acc of
        undefined ->
          case is_uncommon_substring(Substr, A) of
            true ->
              Substr;
            false ->
              undefined
          end;
        Substr ->
          Substr
      end
    end,
    undefined,
    Substrings
  ).

is_uncommon_substring(Substr, A) ->
  not lists:any(fun(Str) -> string:str(Str, Substr) /= 0 end, A).

max_string_length(A) ->
  lists:foldl(fun(Str, Max) -> max(Max, string:len(Str)) end, 0, A).