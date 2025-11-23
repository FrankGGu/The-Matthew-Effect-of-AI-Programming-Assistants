-module(making_file_names_unique).
-export([making_file_names_unique/1]).

making_file_names_unique(Names) ->
    making_file_names_unique(Names, #{}).

making_file_names_unique([], Acc) ->
    [proplists:get_value(Name, Acc, Name) || Name <- lists:reverse(proplists:get_keys(Acc))];
making_file_names_unique([Name | Rest], Acc) ->
    case maps:is_key(Name, Acc) of
        true ->
            K = maps:get(Name, Acc);
            NewName = find_unique_name(Name, K + 1, Acc);
            making_file_names_unique(Rest, maps:put(Name, K + 1, maps:put(NewName, NewName, Acc)));
        false ->
            making_file_names_unique(Rest, maps:put(Name, Name, Acc))
    end.

find_unique_name(Name, K, Acc) ->
    NewName = Name ++ integer_to_list(K);
    case maps:is_key(NewName, Acc) of
        true ->
            find_unique_name(Name, K + 1, Acc);
        false ->
            NewName
    end.