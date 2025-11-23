-module(slm).
-export([sum_subarray_minimums/1]).

sum_subarray_minimums(Nums) ->
    N = length(Nums),
    Left = get_left_indices(Nums),
    Right = get_right_indices(Nums),
    Sum = 0,
    sum_subarray_minimums(Nums, Left, Right, 0, 0, N),
    Sum rem (10^9 + 7).

sum_subarray_minimums(_, _, _, I, Sum, N) when I >= N ->
    Sum;
sum_subarray_minimums(Nums, Left, Right, I, Sum, N) ->
    Count = (I - lists:nth(I+1, Left)) * (lists:nth(I+1, Right) - I),
    NewSum = Sum + lists:nth(I+1, Nums) * Count,
    sum_subarray_minimums(Nums, Left, Right, I+1, NewSum, N).

get_left_indices(Nums) ->
    N = length(Nums),
    Stack = [],
    Result = lists:duplicate(N, -1),
    get_left_indices(Nums, 0, Stack, Result).

get_left_indices(_, N, _, Result) when N >= N ->
    Result;
get_left_indices(Nums, I, Stack, Result) ->
    while_stack(Stack, Nums, I, Result),
    get_left_indices(Nums, I+1, [I | Stack], Result).

while_stack([], _, _, _) -> ok;
while_stack([H | T], Nums, I, Result) ->
    if
        lists:nth(H+1, Nums) > lists:nth(I+1, Nums) ->
            lists:put_element(H+1, Result, I),
            while_stack(T, Nums, I, Result);
        true ->
            ok
    end.

get_right_indices(Nums) ->
    N = length(Nums),
    Stack = [],
    Result = lists:duplicate(N, N),
    get_right_indices(Nums, N-1, Stack, Result).

get_right_indices(_, -1, _, Result) ->
    Result;
get_right_indices(Nums, I, Stack, Result) ->
    while_stack_right(Stack, Nums, I, Result),
    get_right_indices(Nums, I-1, [I | Stack], Result).

while_stack_right([], _, _, _) -> ok;
while_stack_right([H | T], Nums, I, Result) ->
    if
        lists:nth(H+1, Nums) >= lists:nth(I+1, Nums) ->
            lists:put_element(H+1, Result, I),
            while_stack_right(T, Nums, I, Result);
        true ->
            ok
    end.