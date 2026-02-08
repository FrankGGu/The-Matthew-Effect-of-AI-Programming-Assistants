-module(solution).
-export([countTriplets/1]).

countTriplets(Nums) ->
    MaxVal = 1 bsl 16,

    DP = array:new(MaxVal, {default, 0}),

    DP1 = lists:foldl(fun(Num1, AccDP) ->
                        lists:foldl(fun(Num2, InnerAccDP) ->
                                        AndVal = Num1 band Num2,
                                        CurrentCount = array:get(AndVal, InnerAccDP),
                                        array:set(AndVal, CurrentCount + 1, InnerAccDP)
                                    end, AccDP, Nums)
                      end, DP, Nums),

    Result = lists:foldl(fun(Num3, AccResult) ->
                            CurrentSum = lists:foldl(fun(Val, InnerAccSum) ->
                                                        Count = array:get(Val, DP1),
                                                        if Count > 0 andalso (Val band Num3) == 0 ->
                                                            InnerAccSum + Count;
                                                        true ->
                                                            InnerAccSum
                                                        end
                                                    end, 0, lists:seq(0, MaxVal - 1)),
                            AccResult + CurrentSum
                          end, 0, Nums),

    Result.