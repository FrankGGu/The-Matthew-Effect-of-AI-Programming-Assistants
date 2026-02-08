-spec count_smaller(Nums :: [integer()]) -> [integer()].
count_smaller(Nums) ->
    count_smaller(Nums, [], []).

count_smaller([], Acc, Result) -> lists:reverse(Result);
count_smaller([Num | Rest], Acc, Result) ->
    SmallerCount = count_smaller_in_rest(Num, Rest),
    count_smaller(Rest, [SmallerCount | Acc], Result).

count_smaller_in_rest(_, []) -> 0;
count_smaller_in_rest(Num, [Head | Tail]) when Num > Head ->
    1 + count_smaller_in_rest(Num, Tail);
count_smaller_in_rest(Num, [_ | Tail]) ->
    count_smaller_in_rest(Num, Tail).
