%% Definition for NumArray.
%% -record(num_array, {nums = [] :: [integer()]}).

-spec num_array_init_(Nums :: [integer()]) -> any().
num_array_init_(Nums) ->
    {ok, #num_array{nums = Nums}}.

-spec num_array_update(State :: #num_array{}, Index :: integer(), Val :: integer()) -> #num_array{}.
num_array_update(#num_array{nums = Nums} = State, Index, Val) ->
    NewNums = lists:sublist(Nums, 1, Index - 1) ++ [Val] ++ lists:sublist(Nums, Index + 1, length(Nums) - Index),
    #num_array{State | nums = NewNums}.

-spec num_array_sum_range(State :: #num_array{}, Left :: integer(), Right :: integer()) -> integer().
num_array_sum_range(#num_array{nums = Nums}, Left, Right) ->
    lists:sum(lists:sublist(Nums, Left + 1, Right - Left + 1)).
