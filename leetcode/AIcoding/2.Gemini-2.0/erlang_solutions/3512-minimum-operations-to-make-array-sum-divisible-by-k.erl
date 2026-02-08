-module(min_operations).
-export([minOperations/2]).

minOperations(Nums, K) ->
    Sum = lists:sum(Nums),
    if Sum rem K == 0 then
        0
    else
        N = length(Nums),
        lists:foldl(fun(I, {MinLen, PrefixSum, Map}) ->
                          Num = lists:nth(I + 1, Nums),
                          NewPrefixSum = (PrefixSum + Num) rem K,
                          Need = (K - NewPrefixSum) rem K,
                          case maps:is_key(Need, Map) of
                              true ->
                                  OldIndex = maps:get(Need, Map),
                                  NewMinLen = min(MinLen, I - OldIndex + 1);
                              false ->
                                  NewMinLen = MinLen
                          end,
                          NewMap = maps:update_with(NewPrefixSum, fun(X) -> [I | X]; fun(_) -> [I] end, Map),
                          {NewMinLen, NewPrefixSum, NewMap}
                      end, {N + 1, 0, #{0 => [-1]}}, lists:seq(0, N - 1)) of
        {Len, _, _} ->
            if Len > N then
                -1
            else
                Len
            end
        end.