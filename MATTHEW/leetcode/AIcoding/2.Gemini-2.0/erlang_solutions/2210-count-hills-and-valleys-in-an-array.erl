-module(count_hills_valleys).
-export([count_hills_valleys/1]).

count_hills_valleys(Nums) ->
  count_hv(Nums, undefined, 0).

count_hv([H1, H2 | T], Prev, Count) ->
  case compare(H1, H2, Prev) of
    {hill, NewPrev} ->
      count_hv([H2 | T], NewPrev, Count + 1);
    {valley, NewPrev} ->
      count_hv([H2 | T], NewPrev, Count + 1);
    {same, NewPrev} ->
      count_hv([H2 | T], NewPrev, Count);
    none ->
      count_hv([H2 | T], H1, Count)
  end;
count_hv([_], _, Count) ->
  Count;
count_hv([], _, Count) ->
  Count.

compare(H1, H2, Prev) ->
  case Prev of
    undefined ->
      none;
    _ ->
      if
        H1 > H2, Prev < H1 ->
          {hill, H1};
        H1 < H2, Prev > H1 ->
          {valley, H1};
        H1 == H2 ->
          {same, Prev};
        true ->
          {same, H1}
      end
  end.