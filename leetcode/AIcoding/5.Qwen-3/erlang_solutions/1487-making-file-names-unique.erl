-module(making_file_names_unique).
-export([get_modified_string/1]).

get_modified_string(Names) ->
    get_modified_string(Names, dict:new(), []).

get_modified_string([], _Dict, Result) ->
    lists:reverse(Result);
get_modified_string([Name | Rest], Dict, Result) ->
    case dict:is_key(Name, Dict) of
        true ->
            Count = dict:fetch(Name, Dict),
            NewName = Name ++ "(" ++ integer_to_list(Count) ++ ")",
            NewDict = dict:store(Name, Count + 1, Dict),
            get_modified_string(Rest, NewDict, [NewName | Result]);
        false ->
            NewDict = dict:store(Name, 1, Dict),
            get_modified_string(Rest, NewDict, [Name | Result])
    end.