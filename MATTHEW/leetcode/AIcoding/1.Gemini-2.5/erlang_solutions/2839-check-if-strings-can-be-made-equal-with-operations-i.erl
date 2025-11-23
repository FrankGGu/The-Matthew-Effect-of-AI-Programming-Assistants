-module(solution).
-export([canBeEqual/2]).

canBeEqual(S1, S2) ->
    [S1_0, S1_1, S1_2, S1_3] = S1,
    [S2_0, S2_1, S2_2, S2_3] = S2,

    SortedS1_02 = lists:sort([S1_0, S1_2]),
    SortedS2_02 = lists:sort([S2_0, S2_2]),

    SortedS1_13 = lists:sort([S1_1, S1_3]),
    SortedS2_13 = lists:sort([S2_1, S2_3]),

    (SortedS1_02 =:= SortedS2_02) andalso (SortedS1_13 =:= SortedS2_13).