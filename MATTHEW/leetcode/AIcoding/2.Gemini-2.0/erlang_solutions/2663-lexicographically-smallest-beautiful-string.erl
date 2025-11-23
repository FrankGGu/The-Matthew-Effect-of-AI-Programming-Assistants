-module(lexicographically_smallest_beautiful_string).
-export([smallestBeautifulString/2]).

smallestBeautifulString(N, K, S) ->
  smallestBeautifulString_helper(N, K, string:to_list(S)).

smallestBeautifulString_helper(N, K, S) ->
  case find_first_non_z(lists:reverse(S), K, []) of
    none ->
      false;
    {Index, Char} ->
      NewS = lists:reverse(replace_char(lists:reverse(S), Index, Char, K)),
      string:from_list(NewS)
  end.

find_first_non_z([], _, Acc) ->
  none;
find_first_non_z([H|T], K, Acc) ->
  case find_next_valid_char(H, K, length(Acc), Acc) of
    none ->
      find_first_non_z(T, K, [H|Acc]);
    Char ->
      {length(Acc), Char}
  end.

find_next_valid_char(Char, K, Index, Acc) ->
  NextChar = next_char(Char),
  case NextChar of
    false ->
      none;
    C ->
      case is_valid(C, K, Index, Acc) of
        true ->
          C;
        false ->
          find_next_valid_char(C, K, Index, Acc)
      end
  end.

next_char(Char) ->
  case Char of
    122 -> % 'z'
      false;
    _ ->
      Char + 1
  end.

is_valid(Char, K, Index, Acc) ->
  case Index of
    0 ->
      true;
    1 ->
      lists:nth(1, Acc) /= Char;
    _ ->
      lists:nth(1, Acc) /= Char andalso lists:nth(2, Acc) /= Char
  end.

replace_char(S, Index, Char, K) ->
  lists:append(lists:sublist(S, 1, Index), [Char | create_suffix(length(S) - Index - 1, K, [Char|lists:sublist(S,1,Index)])]).

create_suffix(0, _, _) ->
  [];
create_suffix(N, K, Prefix) ->
  case find_first_valid_char(97, K, Prefix) of
    none ->
      []; % Impossible case, K must be big enough
    Char ->
      [Char | create_suffix(N - 1, K, [Char|Prefix])]
  end.

find_first_valid_char(Char, K, Prefix) ->
  case Char > (97 + K - 1) of
    true ->
      none;
    false ->
      case is_suffix_valid(Char, Prefix) of
        true ->
          Char;
        false ->
          find_first_valid_char(Char + 1, K, Prefix)
      end
  end.

is_suffix_valid(Char, Prefix) ->
  case length(Prefix) of
    0 ->
      true;
    _ ->
      case lists:nth(1, Prefix) of
        Char ->
          false;
        Prev ->
          case length(Prefix) > 1 of
            true ->
              case lists:nth(2, Prefix) of
                Char ->
                  false;
                _ ->
                  true
              end;
            false ->
              true
          end
      end
  end.