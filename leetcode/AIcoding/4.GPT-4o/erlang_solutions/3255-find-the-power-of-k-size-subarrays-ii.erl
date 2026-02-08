-module(solution).
-export([sum_subarrays/3]).

sum_subarrays(List, K, P) ->
    Length = length(List),
    Sum = lists:sum(lists:map(fun(X) -> X rem P end, List)),
    case Length < K of
        true -> 0;
        false -> 
            InitialSum = lists:sum(lists:sublist(List, 1, K)),
            Result = calculate(InitialSum, lists:sublist(List, K, Length - K), K, P, Sum),
            Result + (if InitialSum rem P == 0 -> 1; true -> 0 end)
    end.

calculate(CurrentSum, [], K, P, TotalSum) ->
    if CurrentSum rem P == 0 -> 1; true -> 0 end;
calculate(CurrentSum, [Next | Rest], K, P, TotalSum) ->
    NewSum = CurrentSum - (hd(List) rem P) + (Next rem P),
    Result = calculate(NewSum, Rest, K, P, TotalSum),
    Result + (if NewSum rem P == 0 -> 1; true -> 0 end).