-module(last_stone_weight).
-export([last_stone_weight/1]).

last_stone_weight(Stones) ->
  heap_sort(Stones).

heap_sort(Stones) ->
  build_max_heap(Stones, length(Stones)),
  heap_sort_recursive(Stones, length(Stones)).

heap_sort_recursive([H|T], 1) ->
  H;
heap_sort_recursive(Stones, N) ->
  {Max, Rest} = swap_and_heapify(Stones, N),
  heap_sort_recursive(Rest, N - 1).

swap_and_heapify(Stones, N) ->
  {Max, Rest} = lists:split(N - 1, Stones),
  [H] = lists:last(Stones),
  Rest2 = lists:sublist(Rest, 1, N - 1),
  Heapified = max_heapify([lists:first(Rest2) | lists:droplast(Rest2)], N - 1, 1),
  {H, Heapified}.

build_max_heap(Stones, N) ->
  build_max_heap_recursive(Stones, N, N div 2).

build_max_heap_recursive(Stones, N, I) when I < 1 ->
  max_heapify(Stones, N, 1);
build_max_heap_recursive(Stones, N, I) ->
  Stones2 = max_heapify(Stones, N, I),
  build_max_heap_recursive(Stones2, N, I - 1).

max_heapify(Stones, N, I) ->
  L = 2 * I,
  R = 2 * I + 1,
  Largest =
    case {L =< N, element(L, [0|Stones]) > element(I, [0|Stones])} of
      {true, true} -> L;
      _ -> I
    end,
  Largest2 =
    case {R =< N, element(R, [0|Stones]) > element(Largest, [0|Stones])} of
      {true, true} -> R;
      _ -> Largest
    end,
  if
    Largest2 /= I ->
      {NewStones, _} = swap(Stones, I, Largest2),
      max_heapify(NewStones, N, Largest2);
    true ->
      Stones
  end.

swap(Stones, I, J) ->
  ValI = element(I, [0|Stones]),
  ValJ = element(J, [0|Stones]),
  Stones2 = setelement(I, [0|Stones], ValJ),
  Stones3 = setelement(J, Stones2, ValI),
  {Stones3, ok}.

heap_sort_recursive([], _) -> 0;
heap_sort_recursive([A], _) -> A;
heap_sort_recursive([A, B], _) -> abs(A-B);
heap_sort_recursive(L, _) ->
    L1 = lists:sort(L),
    [A, B | Tail] = lists:reverse(L1),
    NewL = [abs(A - B) | Tail],
    heap_sort_recursive(NewL, _).