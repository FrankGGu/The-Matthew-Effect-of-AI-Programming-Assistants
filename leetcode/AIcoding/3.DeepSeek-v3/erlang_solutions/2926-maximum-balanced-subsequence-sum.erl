-module(solution).
-export([max_balanced_subsequence_sum/1]).

max_balanced_subsequence_sum(Nums) ->
    {_, _, MaxSum} = lists:foldl(fun process_num/2, {[], [], -inf}, Nums),
    MaxSum.

process_num(Num, {List, BIT, MaxSum}) ->
    {NewList, NewBIT, NewMaxSum} = insert(List, BIT, Num, MaxSum),
    {NewList, NewBIT, max(NewMaxSum, Num)}.

insert(List, BIT, Num, MaxSum) ->
    case List of
        [] ->
            {[Num], update(1, Num, BIT), Num};
        _ ->
            Index = find_index(List, Num - length(List)),
            Sum = if Index == 0 -> 0; true -> query(BIT, Index) end,
            NewSum = Sum + Num,
            NewList = insert_into_list(List, Index + 1, Num),
            NewBIT = update(Index + 1, NewSum, BIT),
            {NewList, NewBIT, max(MaxSum, NewSum)}
    end.

find_index(List, Value) ->
    find_index(List, Value, 0, length(List)).

find_index([], _, Low, _) -> Low;
find_index([H|T], Value, Low, High) ->
    Mid = (Low + High) div 2,
    if
        H >= Value -> find_index(lists:sublist(List, Low, Mid - Low), Value, Low, Mid - 1);
        true -> find_index(T, Value, Mid + 1, High)
    end.

insert_into_list(List, Index, Value) ->
    {Left, Right} = lists:split(Index - 1, List),
    Left ++ [Value] ++ Right.

update(Index, Value, BIT) ->
    case Index > length(BIT) of
        true -> BIT ++ lists:duplicate(Index - length(BIT), -inf) ++ [Value];
        false -> 
            Old = lists:nth(Index, BIT),
            lists:sublist(BIT, Index - 1) ++ [max(Old, Value)] ++ lists:nthtail(Index, BIT)
    end.

query(BIT, Index) ->
    query(BIT, Index, -inf).

query([], _, Acc) -> Acc;
query([H|T], Index, Acc) when Index > 0 ->
    query(T, Index - 1, max(Acc, H));
query(_, _, Acc) -> Acc.