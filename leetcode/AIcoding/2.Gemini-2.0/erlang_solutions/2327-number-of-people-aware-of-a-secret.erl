-module(secret).
-export([number_of_people_aware_of_a_secret/3]).

number_of_people_aware_of_a_secret(N, Delay, Forget) ->
    number_of_people_aware_of_a_secret(N, Delay, Forget, 1, [1]).

number_of_people_aware_of_a_secret(N, Delay, Forget, Day, Aware) when Day >= N ->
    lists:sum(Aware) rem (1000 * 1000 * 1000 + 7);

number_of_people_aware_of_a_secret(N, Delay, Forget, Day, Aware) ->
    NewAware = lists:sum([
        case Day - I >= Delay and Day - I < Forget of
            true -> Aware !! (I - 1);
            false -> 0
        end
     || I <- lists:seq(1, length(Aware))
    ]),

    NewAwareList = Aware ++ [NewAware rem (1000 * 1000 * 1000 + 7)],
    FilteredAwareList = lists:sublist(NewAwareList, length(NewAwareList) - min(length(NewAwareList) -1, Forget -1)),

    number_of_people_aware_of_a_secret(N, Delay, Forget, Day + 1, FilteredAwareList).