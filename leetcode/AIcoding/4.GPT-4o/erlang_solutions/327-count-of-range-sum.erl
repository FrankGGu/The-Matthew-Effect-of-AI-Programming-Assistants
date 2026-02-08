-spec count_range_sum(Nums :: [integer()], Lower :: integer(), Upper :: integer()) -> integer().
count_range_sum(Nums, Lower, Upper) ->
    count_range_sum(Nums, Lower, Upper, 0, 0, []).

count_range_sum([], _, _, Count, _) -> Count;
count_range_sum([H | T], Lower, Upper, Count, Prefix) ->
    NewPrefix = [H + lists:sum(Prefix) | Prefix],
    NewCount = lists:foldl(fun(Sum, Acc) -> 
                             if 
                               Sum >= Lower andalso Sum =< Upper -> Acc + 1;
                               true -> Acc
                             end
                           end, Count, NewPrefix),
    count_range_sum(T, Lower, Upper, NewCount, NewPrefix).
