-module(solution).
-export([is_hash_divided/2]).

is_hash_divided(S, K) ->
    N = length(S),

    if
        K == 0 -> S == [];
        K > N -> false;
        true ->
            TotalSum = lists:sum(S),
            case TotalSum rem K of
                0 ->
                    TargetSum = TotalSum div K,

                    {_, _, PrefixSumsMap} = lists:foldl(fun(Char, {CurrentSum, Index, AccMap}) ->
                                                             NewSum = CurrentSum + Char,
                                                             {NewSum, Index + 1, AccMap#{ Index + 1 => NewSum }}
                                                     end, {0, 0, #{0 => 0}}, S),

                    PrevLayerDP_Map = #{0 => true},

                    FinalLayerDP_Map = lists:foldl(fun(J, AccPrevLayerDP_Map) ->
                                                        CurrentLayerDP_Map = lists:foldl(fun(I, AccMap) ->
                                                                                             CurrentPrefixSum = maps:get(I, PrefixSumsMap),
                                                                                             RequiredPrevPrefixSum = CurrentPrefixSum - TargetSum,
                                                                                             case maps:is_key(RequiredPrevPrefixSum, AccPrevLayerDP_Map) of
                                                                                                 true -> AccMap#{ CurrentPrefixSum => true };
                                                                                                 false -> AccMap
                                                                                             end
                                                                                         end, #{}, lists:seq(1, N)),
                                                        CurrentLayerDP_Map
                                                    end, PrevLayerDP_Map, lists::seq(1, K)),

                    maps:is_key(TotalSum, FinalLayerDP_Map);
                _ -> false
            end
    end.