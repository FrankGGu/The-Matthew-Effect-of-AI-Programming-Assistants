-module(solution).
-export([num_subarrays/1]).

num_subarrays(Nums) ->
    N = length(Nums),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
                        lists:foldl(fun(J, Acc2) ->
                                            if J >= I ->
                                                Sub = lists:sublist(Nums, I+1, J-I),
                                                case is_increasing(Sub) of
                                                    true -> Acc2 + 1;
                                                    false -> Acc2
                                                end;
                                            true -> Acc2
                                        end, Acc, lists:seq(I+1, N-1))
                    end, Count, lists:seq(0, N-1)).

is_increasing([]) -> true;
is_increasing([_]) -> true;
is_increasing([A, B | T]) ->
    A < B andalso is_increasing([B | T]).