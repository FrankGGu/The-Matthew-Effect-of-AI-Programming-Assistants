-module(permutations_ii).
-export([permute/1]).

permute(Nums) ->
    permute(Nums, []).

permute([], Acc) ->
    [lists:reverse(Acc)];
permute(Nums, Acc) ->
    Perms = [],
    Used = sets:new(),
    permute(Nums, Acc, Used, Perms).

permute(_Nums, _Acc, _Used, Perms) when Perms /= [] ->
    Perms;
permute(Nums, Acc, Used, Perms) ->
    Lists = lists:usort(Nums),
    lists:foldl(fun(N, Acc2) ->
        case sets:is_element(N, Used) of
            true -> Acc2;
            false ->
                NewUsed = sets:add_element(N, Used),
                NewAcc = [N | Acc],
                case lists:member(N, Acc) of
                    true -> Acc2;
                    false ->
                        case permute(Nums -- [N], NewAcc, NewUsed, Perms) of
                            [] -> Acc2;
                            P -> Acc2 ++ P
                        end
                end
        end
    end, [], Lists).

--([]) -> [];
--([H|T]) -> T.

lists:member(X, L) ->
    lists:member(X, L).

lists:usort(L) ->
    lists:usort(L).

sets:new() ->
    sets:new().

sets:add_element(X, S) ->
    sets:add_element(X, S).

sets:is_element(X, S) ->
    sets:is_element(X, S).