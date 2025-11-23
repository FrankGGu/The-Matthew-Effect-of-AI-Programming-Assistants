-module(solution).
-export([license_key_formatting/2]).

-spec license_key_formatting(unicode:unicode_binary(), integer()) -> unicode:unicode_binary().
license_key_formatting(S, K) ->
    S1 = string:replace(S, "-", "", all), %% Remove all dashes
    S2 = string:upper(S1),              %% Convert all letters to uppercase
    Groups = split_into_groups(S2, K),  %% Split the string into groups of size K
    lists:join("-", Groups).            %% Join the groups with dashes

%% Helper function to split the string into groups of size K
split_into_groups(S, K) ->
    split_groups(S, K, []).

%% Recursively split the string into groups
split_groups([], _, Acc) -> 
    lists:reverse(Acc);
split_groups(S, K, Acc) when length(S) =< K -> 
    lists:reverse([S | Acc]);
split_groups(S, K, Acc) ->
    {Group, Rest} = lists:split(K, S),
    split_groups(Rest, K, [Group | Acc]).
