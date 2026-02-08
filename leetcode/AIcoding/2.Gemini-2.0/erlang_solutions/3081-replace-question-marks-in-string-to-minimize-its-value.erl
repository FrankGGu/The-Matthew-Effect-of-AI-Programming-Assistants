-module(replace_question_marks).
-export([modify_string/1]).

modify_string(S) ->
  modify_string(S, []).

modify_string([], Acc) ->
  lists:reverse(Acc);
modify_string([$? | T], Acc) ->
  L = lists:reverse(Acc),
  Last = case L of
           [] -> $;
           [H|_] -> H
         end,
  Next = case T of
           [] -> $;
           [H|_] -> H
         end,
  Char = find_char(Last, Next),
  modify_string(T, [Char | Acc]);
modify_string([H | T], Acc) ->
  modify_string(T, [H | Acc]).

find_char(L, N) ->
  case L of
    $a ->
      case N of
        $a -> $b;
        $b -> $c;
        $c -> $b;
        _ -> $b
      end;
    $b ->
      case N of
        $a -> $c;
        $b -> $c;
        $c -> $a;
        _ -> $c
      end;
    $c ->
      case N of
        $a -> $b;
        $b -> $a;
        $c -> $a;
        _ -> $a
      end;
    _ ->
      case N of
        $a -> $b;
        $b -> $c;
        $c -> $b;
        _ -> $a
      end
  end.