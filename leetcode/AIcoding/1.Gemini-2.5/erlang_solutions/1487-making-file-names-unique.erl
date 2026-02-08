-module(solution).
-export([make_file_names_unique/1]).

make_file_names_unique(Names) ->
    make_file_names_unique(Names, [], maps:new(), maps:new()).

make_file_names_unique([], Acc, _SeenNames, _NameCounts) ->
    lists:reverse(Acc);
make_file_names_unique([Name | Rest], Acc, SeenNames, NameCounts) ->
    case maps:is_key(Name, SeenNames) of
        false ->
            NewSeenNames = maps:put(Name, true, SeenNames),
            NewNameCounts = maps:put(Name, 1, NameCounts),
            make_file_names_unique(Rest, [Name | Acc], NewSeenNames, NewNameCounts);
        true ->
            K = maps:get(Name, NameCounts, 1),
            {UniqueName, NextK, FinalSeenNames} = find_unique_suffixed_name(Name, K, SeenNames),
            NewNameCounts = maps:put(Name, NextK, NameCounts),
            make_file_names_unique(Rest, [UniqueName | Acc], FinalSeenNames, NewNameCounts)
    end.

find_unique_suffixed_name(BaseName, K, SeenNames) ->
    CandidateName = BaseName ++ "(" ++ integer_to_list(K) ++ ")",
    case maps:is_key(CandidateName, SeenNames) of
        false ->
            NewSeenNames = maps:put(CandidateName, true, SeenNames),
            {CandidateName, K + 1, NewSeenNames};
        true ->
            find_unique_suffixed_name(BaseName, K + 1, SeenNames)
    end.