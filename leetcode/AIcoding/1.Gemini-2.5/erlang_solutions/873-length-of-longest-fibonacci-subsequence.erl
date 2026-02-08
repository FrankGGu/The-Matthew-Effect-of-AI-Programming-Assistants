-module(solution).
-export([lenLongestFibSubseq/1]).

lenLongestFibSubseq(Arr) ->
    N = length(Arr),

    ArrArray = array:from_list(Arr),

    ValToIndex = maps:from_list(lists:zip(Arr, lists:seq(0, N - 1))),

    DP = #{},
    MaxLen = 0,

    {_FinalDP, FinalMaxLen} = lists:foldl(
        fun(J, {CurrentDP, CurrentMaxLen}) ->
            ArrJ = array:get(J, ArrArray),
            lists:foldl(
                fun(I, {InnerDP, InnerMaxLen}) ->
                    ArrI = array:get(I, ArrArray),
                    PrevVal = ArrJ - ArrI,

                    case PrevVal < ArrI andalso maps:is_key(PrevVal, ValToIndex) of
                        true ->
                            K = maps:get(PrevVal, ValToIndex),
                            Len = maps:get({K, I}, InnerDP, 2) + 1,
                            {maps:put({I, J}, Len, InnerDP), max(InnerMaxLen, Len)};
                        false ->
                            {InnerDP, InnerMaxLen}
                    end
                end,
                {CurrentDP, CurrentMaxLen},
                lists:seq(0, J - 1)
            )
        end,
        {DP, MaxLen},
        lists:seq(0, N - 1)
    ),
    FinalMaxLen.