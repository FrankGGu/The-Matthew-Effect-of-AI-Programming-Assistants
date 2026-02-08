-module(solution).
-export([min_damage/2]).

min_damage(Damage, Armor) ->
    SortedDamage = lists:sort(Damage),
    SortedArmor = lists:sort(Armor),

    N = length(SortedDamage),
    M = length(SortedArmor),

    if
        N =< M ->
            calculate_damage(SortedDamage, lists:sublist(SortedArmor, N))
        ;
        N > M ->
            UnshieldedDamageList = lists:sublist(SortedDamage, N - M),
            UnshieldedTotalDamage = lists:sum(UnshieldedDamageList),

            ShieldedDamageList = lists:nthtail(N - M, SortedDamage),

            ShieldedTotalDamage = calculate_damage(ShieldedDamageList, SortedArmor),

            UnshieldedTotalDamage + ShieldedTotalDamage
    end.

calculate_damage([], []) -> 0;
calculate_damage([D|Ds], [A|As]) ->
    erlang:max(0, D - A) + calculate_damage(Ds, As).