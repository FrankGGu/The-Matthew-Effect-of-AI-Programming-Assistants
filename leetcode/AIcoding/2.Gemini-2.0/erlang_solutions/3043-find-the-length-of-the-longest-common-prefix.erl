-module(longest_common_prefix).
-export([longest_common_prefix/1]).

longest_common_prefix(Strs) ->
  case Strs of
    [] -> "";
    [Single] -> Single;
    _ ->
      Prefix = lists:nth(1, Strs),
      longest_common_prefix_helper(Prefix, lists:nthtail(1, Strs))
  end.

longest_common_prefix_helper(Prefix, []) ->
  Prefix;
longest_common_prefix_helper(Prefix, [Next | Rest]) ->
  NewPrefix = find_common_prefix(Prefix, Next),
  longest_common_prefix_helper(NewPrefix, Rest).

find_common_prefix("", _) ->
  "";
find_common_prefix(_, "") ->
  "";
find_common_prefix(Str1, Str2) ->
  find_common_prefix_helper(Str1, Str2, 1).

find_common_prefix_helper(Str1, Str2, Index) ->
  try
    Char1 = string:substr(Str1, Index, 1),
    Char2 = string:substr(Str2, Index, 1),
    case Char1 =:= Char2 of
      true ->
        find_common_prefix_helper(Str1, Str2, Index + 1);
      false ->
        string:substr(Str1, 1, Index - 1)
    end
  catch
    _:_ ->
      case string:len(Str1) < Index or string:len(Str2) < Index of
        true ->
          case string:len(Str1) < string:len(Str2) of
            true -> Str1;
            false -> string:substr(Str1, 1, string:len(Str2))
          end;
        false ->
          string:substr(Str1, 1, Index - 1)
      end
  end.