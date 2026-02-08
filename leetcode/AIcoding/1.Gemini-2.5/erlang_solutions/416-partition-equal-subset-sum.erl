-module(solution).
-export([canPartition/1]).

canPartition(Nums) ->
    TotalSum = lists:sum(Nums),
    if
        TotalSum rem 2 =/= 0 ->
            false;
        true ->
            Target = TotalSum div 2,
            DP = #{0 => true}, % DP map: Key is sum, Value indicates if sum is reachable.
            FinalDP = lists:foldl(fun(Num, CurrentDP) ->
                                      update_dp_state(Num, Target, CurrentDP)
                                  end, DP, Nums),
            maps:is_key(Target, FinalDP)
    end.

update_dp_state(Num, Target, CurrentDP) ->
    % Iterate from Target down to Num to ensure each number is used at most once.
    % We build a new map (AccDP) based on CurrentDP.
    lists:foldl(fun(J, AccDP) ->
                    if
                        J >= Num andalso maps:is_key(J - Num, CurrentDP) ->
                            maps:put(J, true, AccDP);
                        true ->
                            AccDP
                    end
                end, CurrentDP, lists:seq(Target, Num, -1)).