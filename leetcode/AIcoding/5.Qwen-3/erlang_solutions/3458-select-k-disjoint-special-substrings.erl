-module(solution).
-export([k_disjoint_special_substrings/2]).

k_disjoint_special_substrings(S, K) ->
    N = erlang:length(S),
    Map = maps:new(),
    List = lists:seq(0, N - 1),
    {_, Result} = lists:foldl(fun(I, {MapAcc, Acc}) ->
        Char = string:substr(S, I + 1, 1),
        case maps:is_key(Char, MapAcc) of
            true ->
                NewMap = maps:update(Char, [I | maps:get(Char, MapAcc)], MapAcc),
                {NewMap, Acc};
            false ->
                NewMap = maps:put(Char, [I], MapAcc),
                {NewMap, Acc}
        end
    end, {Map, []}, List),
    Sorted = lists:sort(fun({A, B}, {C, D}) -> A < C end, maps:to_list(Result)),
    Count = length(Sorted),
    if
        Count < K -> -1;
        true ->
            Total = lists:foldl(fun({_Char, Positions}, Acc) ->
                lists:foldl(fun(P, A) ->
                    lists:foldl(fun(Q, B) ->
                        if P /= Q andalso abs(P - Q) >= 2 -> B + 1;
                           true -> B
                        end
                    end, A, Positions)
                end, Acc, Positions)
            end, 0, Sorted),
            Total
    end.