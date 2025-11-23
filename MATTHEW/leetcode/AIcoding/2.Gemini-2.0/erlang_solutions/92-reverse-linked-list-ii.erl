-module(reverse_between).
-export([reverse_between/3]).

reverse_between(Head, Left, Right) ->
  reverse_between(Head, Left, Right, 1, Head, nil).

reverse_between(Head, Left, Right, N, Curr, Prev) ->
  case N of
    N when N < Left ->
      reverse_between(Head, Left, Right, N + 1, Curr band tl(Curr), Curr);
    N when N =:= Left ->
      reverse_between(Head, Left, Right, N, Curr, Prev, nil, N);
    _ ->
      Head
  end.

reverse_between(Head, Left, Right, N, Curr, Prev, ReversedHead, ReversedTailPos) ->
  case N of
    N when N =< Right ->
      Next = tl(Curr),
      Curr#node.next := ReversedHead,
      reverse_between(Head, Left, Right, N + 1, Next, Curr, Curr, ReversedTailPos);
    _ ->
      Tail = tl(Curr),
      if Left =:= 1 then
        Head = Curr,
        case Prev of
          nil ->
            Head;
          _ ->
            Prev#node.next := Curr,
            Head
        end,
        hd(lists:nth(ReversedTailPos, lists:seq(1,Right))#node.next := Tail),
        Head
      else
        hd(lists:nth(Left - 1, lists:seq(1,Right))#node.next := Curr),
        case Prev of
          nil ->
            Head;
          _ ->
            Prev#node.next := Curr,
            Head
        end,
        hd(lists:nth(ReversedTailPos, lists:seq(1,Right))#node.next := Tail),
        Head
      end
  end.