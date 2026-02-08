-module(solution).
-export([maxSatisfied/3]).

maxSatisfied(Customers, Grumpy, X) ->
    {BaseSatisfied, PotentialGainListRev} = lists:foldl(
        fun({Customer, GrumpyStatus}, {AccBase, AccPotential}) ->
            if
                GrumpyStatus == 0 -> {AccBase + Customer, [0 | AccPotential]};
                true -> {AccBase, [Customer | AccPotential]}
            end
        end,
        {0, []},
        lists:zip(Customers, Grumpy)
    ),
    PotentialGainList = lists:reverse(PotentialGainListRev),

    MaxWindowGain = calculate_max_window_gain(PotentialGainList, X),

    BaseSatisfied + MaxWindowGain.

calculate_max_window_gain(PotentialGainList, X) ->
    Len = length(PotentialGainList),
    if
        Len == 0 -> 0;
        X >= Len -> lists:sum(PotentialGainList);
        true ->
            PrefixSumsListRev = lists:foldl(fun(E, Acc) -> [lists:hd(Acc) + E | Acc] end, [0], PotentialGainList),
            PrefixSumsList = lists:reverse(PrefixSumsListRev),
            PrefixSumsArray = array:from_list(PrefixSumsList),

            InitialMaxGain = array:get(X, PrefixSumsArray) - array:get(0, PrefixSumsArray),

            MaxGain = lists:foldl(
                fun(I, CurrentMax) ->
                    WindowSum = array:get(I + X, PrefixSumsArray) - array:get(I, PrefixSumsArray),
                    max(CurrentMax, WindowSum)
                end,
                InitialMaxGain,
                lists:seq(1, Len - X)
            ),
            MaxGain
    end.