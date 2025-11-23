-module(remove_trailing_zeros).
-export([remove_trailing_zeros/1]).

remove_trailing_zeros(S) ->
  remove_trailing_zeros_helper(S, string:len(S)).

remove_trailing_zeros_helper(S, Index) ->
  case Index of
    0 -> "";
    _ ->
      case string:at(S, Index) of
        $0 -> remove_trailing_zeros_helper(S, Index - 1);
        _ -> string:sub(S, 1, Index)
      end
  end.