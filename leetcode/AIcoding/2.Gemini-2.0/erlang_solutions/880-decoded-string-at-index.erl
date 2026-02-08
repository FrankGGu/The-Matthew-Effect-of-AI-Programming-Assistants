-module(decoded_string_at_index).
-export([decodeAtIndex/2]).

decodeAtIndex(S, K) ->
  decodeAtIndex_helper(S, K, get_length(S, 0)).

decodeAtIndex_helper(S, K, Length) ->
  case K of
    1 ->
      case string:at(S, 1) of
        undefined ->
          decodeAtIndex_helper(S, 1, Length - 1);
        C ->
          case is_digit(C) of
            true ->
              decodeAtIndex_helper(S, 1, Length div (C - $0));
            false ->
              string:at(S, 1)
          end
      end;
    _ ->
      case string:at(S, Length) of
        undefined ->
          decodeAtIndex_helper(S, K, Length - 1);
        C ->
          case is_digit(C) of
            true ->
              decodeAtIndex_helper(S, K rem (Length div (C - $0)), Length div (C - $0));
            false ->
              if K =:= Length then
                string:at(S, Length)
              else
                decodeAtIndex_helper(S, K, Length - 1)
              end
          end
      end
  end.

get_length(S, Acc) ->
  case string:at(S, Acc + 1) of
    undefined ->
      Acc;
    C ->
      case is_digit(C) of
        true ->
          get_length(S, Acc + (Acc + 1) * (C - $1));
        false ->
          get_length(S, Acc + 1)
      end
  end.

is_digit(C) ->
  C >= $0 andalso C =< $9.