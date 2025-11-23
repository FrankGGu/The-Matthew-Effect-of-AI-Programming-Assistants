-module(replace_all_qs).
-export([modify_string/1]).

modify_string(S) ->
  modify_string(S, []).

modify_string([], Acc) ->
  lists:reverse(Acc);
modify_string([? | Rest], Acc) ->
  Prev = case Acc of
           [] -> '$';
           [H | _] -> H
         end,
  Next = case Rest of
           [] -> '$';
           [H | _] -> H
         end,
  C = find_char(Prev, Next),
  modify_string(Rest, [C | Acc]);
modify_string([H | Rest], Acc) ->
  modify_string(Rest, [H | Acc]).

find_char(Prev, Next) ->
  case Prev of
    'a' ->
      case Next of
        'b' -> 'c';
        'c' -> 'b';
        _ -> 'b'
      end;
    'b' ->
      case Next of
        'a' -> 'c';
        'c' -> 'a';
        _ -> 'a'
      end;
    'c' ->
      case Next of
        'a' -> 'b';
        'b' -> 'a';
        _ -> 'a'
      end;
    _ -> 'a'
  end.