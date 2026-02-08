-module(solution).
-export([can_divide/2]).

can_divide(Numbers, K) ->
    Sorted = lists:sort(Numbers),
    can_divide_helper(Sorted, K, []).

can_divide_helper([], _K, _Acc) -> 
    true;
can_divide_helper(Numbers, K, Acc) when length(Acc) < K ->
    {H, _T} = hd(Numbers),
    NewAcc = [H | Acc],
    NewNumbers = lists:filter(fun(X) -> X =\= H end, Numbers),
    can_divide_helper(NewNumbers, K, NewAcc);
can_divide_helper(Numbers, K, Acc) ->
    [H | T] = Acc,
    NewAcc = lists:map(fun(X) -> X - 1 end, Acc),
    case lists:all(fun(X) -> X >= 0 end, NewAcc) of
        true ->
            NewNumbers = lists:foldl(fun(X, Acc1) -> if lists:member(X, NewAcc) -> Acc1; true -> [X | Acc1] end end, [], Numbers),
            can_divide_helper(NewNumbers, K, NewAcc);
        false -> 
            false
    end.