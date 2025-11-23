-module(solution).
-export([minimum_score/2]).

minimum_score(Nums, Edges) ->
    N = length(Nums),
    Adj = lists:foldl(fun([U, V], Acc) ->
                          maps:update_with(U, fun(L) -> [V | L] end, [V], Acc)
                      end, #{}, Edges),
    Adj1 = lists:foldl(fun([U, V], Acc) ->
                           maps:update_with(V, fun(L) -> [U | L] end, [U], Acc)
                       end, Adj, Edges),
    {Total, _} = xor_total(Nums, 0, 0),
    {Xor, Parent, In, Out, _} = dfs(0, -1, Adj1, Nums, #{}, #{}, 0, 0),
    {Res, _} = find_min(0, -1, Adj1, Nums, Parent, In, Out, Total, Total),
    Res.

xor_total([], Acc, I) -> {Acc, I};
xor_total([H | T], Acc, I) -> xor_total(T, Acc bxor H, I + 1).

dfs(U, P, Adj, Nums, Parent, In, Out, Time, Xor) ->
    Xor1 = Xor bxor lists:nth(U + 1, Nums),
    Parent1 = maps:put(U, P, Parent),
    Time1 = Time + 1,
    In1 = maps:put(U, Time1, In),
    Children = maps:get(U, Adj, []),
    {Xor2, Parent2, In2, Out2, Time2} = 
        lists:foldl(fun(V, {XorAcc, ParentAcc, InAcc, OutAcc, TimeAcc}) ->
            case V =/= P of
                true ->
                    {XorV, ParentV, InV, OutV, TimeV} = dfs(V, U, Adj, Nums, ParentAcc, InAcc, OutAcc, TimeAcc, XorAcc),
                    {XorV, ParentV, InV, OutV, TimeV};
                false ->
                    {XorAcc, ParentAcc, InAcc, OutAcc, TimeAcc}
            end
        end, {Xor1, Parent1, In1, Out, Time1}, Children),
    Time3 = Time2 + 1,
    Out3 = maps:put(U, Time3, Out2),
    {Xor2, Parent2, In2, Out3, Time3}.

find_min(U, P, Adj, Nums, Parent, In, Out, Total, Min) ->
    Children = maps:get(U, Adj, []),
    lists:foldl(fun(V, {CurrentMin, CurrentXor}) ->
        case V =/= P of
            true ->
                {ChildMin, ChildXor} = find_min(V, U, Adj, Nums, Parent, In, Out, Total, CurrentMin),
                Xor1 = ChildXor,
                Xor2 = Total bxor Xor1,
                NewMin1 = min(CurrentMin, max(Xor1, max(Xor2, Total bxor Xor1 bxor Xor2)) - min(Xor1, min(Xor2, Total bxor Xor1 bxor Xor2)),
                {NewMin1, Xor1};
            false ->
                {CurrentMin, CurrentXor}
        end
    end, {Min, lists:nth(U + 1, Nums)}, Children).