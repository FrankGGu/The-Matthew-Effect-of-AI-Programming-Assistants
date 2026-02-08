-module(beautiful_towers_ii).
-export([maximum_sum_of_heights/1]).

maximum_sum_of_heights(MaxHeights) ->
  N = length(MaxHeights),
  {Left, Right} = calculate_sums(MaxHeights, N),
  lists:foldl(fun(I, Acc) -> max(Acc, Left[I] + Right[I] - MaxHeights[I]) end, 0, lists:seq(1, N)).

calculate_sums(MaxHeights, N) ->
  {Left, Right} = calculate_left(MaxHeights, N),
  {Left, calculate_right(MaxHeights, N)}.

calculate_left(MaxHeights, N) ->
  {Stack, Left} = lists:foldl(fun(I, {S, Acc}) ->
    H = lists:nth(I, MaxHeights),
    {NewS, Sum} = update_stack(S, H, I, Acc),
    {[I | NewS], [Sum | Acc]}
  end, {[], []}, lists:seq(1, N)),
  {lists:reverse(Left), []}.

calculate_right(MaxHeights, N) ->
  {Stack, Right} = lists:foldl(fun(I, {S, Acc}) ->
    H = lists:nth(I, MaxHeights),
    {NewS, Sum} = update_stack(S, H, I, Acc),
    {[I | NewS], [Sum | Acc]}
  end, {[], []}, lists:reverse(lists:seq(1, N))),
  lists:reverse(Right).

update_stack(Stack, H, I, Acc) ->
  {NewStack, Sum} = remove_smaller(Stack, H, I, Acc),
  case NewStack of
    [] -> {[], H * I};
    [Top | _] -> {NewStack, hd(Acc) + H * (I - Top)}
  end.

remove_smaller(Stack, H, I, Acc) ->
  remove_smaller_helper(Stack, H, I, Acc, []).

remove_smaller_helper([], _H, _I, _Acc, Removed) ->
  {lists:reverse(Removed), []};
remove_smaller_helper([Top | Rest], H, I, Acc, Removed) ->
  if lists:nth(Top, lists:seq(1, length(lists:seq(1, length(Acc))))) >= H then
    {[Top | lists:reverse(Removed)], lists:nth(length(lists:seq(1, length(Acc))), Acc)}
  else
    remove_smaller_helper(Rest, H, I, Acc, [Top | Removed])
  end.