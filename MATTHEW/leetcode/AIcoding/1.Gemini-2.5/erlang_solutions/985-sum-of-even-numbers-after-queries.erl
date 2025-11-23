-module(solution).
-export([sum_even_after_queries/2]).

sum_even_after_queries(A, Queries) ->
    InitialEvenSum = lists:foldl(fun(X, Acc) ->
                                     if X rem 2 == 0 -> Acc + X;
                                        true -> Acc
                                     end
                                 end, 0, A),

    Arr = array:from_list(A),

    process_queries(Queries, Arr, InitialEvenSum, []).

process_queries([], _Arr, _CurrentEvenSum, Acc) ->
    lists:reverse(Acc);

process_queries([[Val, Index] | RestQueries], Arr, CurrentEvenSum, Acc) ->
    OldVal = array:get(Index, Arr),
    NewVal = OldVal + Val,

    UpdatedEvenSum =
        case {OldVal rem 2 == 0, NewVal rem 2 == 0} of
            {true, true} -> CurrentEvenSum - OldVal + NewVal;
            {true, false} -> CurrentEvenSum - OldVal;
            {false, true} -> CurrentEvenSum + NewVal;
            {false, false} -> CurrentEvenSum
        end,

    NewArr = array:set(Index, NewVal, Arr),

    process_queries(RestQueries, NewArr, UpdatedEvenSum, [UpdatedEvenSum | Acc]).