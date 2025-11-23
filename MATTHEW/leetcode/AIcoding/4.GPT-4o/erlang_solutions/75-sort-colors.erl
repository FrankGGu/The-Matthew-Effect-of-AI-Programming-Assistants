%% Sort Colors
%% -record(list_node, {val = 0 :: integer(), next = null :: 'null' | #list_node{}}).

-spec sort_colors(Nums :: list(integer())) -> list(integer()).
sort_colors(Nums) ->
    sort_colors(Nums, 0, 0, 0).

sort_colors([], _, _, _) -> [];
sort_colors([H | T], ZeroCount, OneCount, TwoCount) when H == 0 ->
    sort_colors(T, ZeroCount + 1, OneCount, TwoCount);
sort_colors([H | T], ZeroCount, OneCount, TwoCount) when H == 1 ->
    sort_colors(T, ZeroCount, OneCount + 1, TwoCount);
sort_colors([H | T], ZeroCount, OneCount, TwoCount) when H == 2 ->
    sort_colors(T, ZeroCount, OneCount, TwoCount + 1);
sort_colors([], ZeroCount, OneCount, TwoCount) ->
    lists:append(lists:duplicate(ZeroCount, 0), 
                 lists:append(lists:duplicate(OneCount, 1), 
                              lists:duplicate(TwoCount, 2))).
