-module(solution).
-export([get_folder_names/1]).

get_folder_names(Folders) ->
    UniqueNames = lists:foldl(fun(Name, Acc) ->
        case maps:is_key(Name, Acc) of
            true ->
                NewName = generate_new_name(Name, Acc),
                maps:put(NewName, true, Acc);
            false ->
                maps:put(Name, true, Acc)
        end
    end, maps:new(), Folders),
    maps:keys(UniqueNames).

generate_new_name(Name, Acc) ->
    NewNameSuffix = generate_suffix(Name, 1),
    NewName = Name ++ integer_to_list(NewNameSuffix),
    case maps:is_key(NewName, Acc) of
        true -> generate_new_name(Name, Acc, NewNameSuffix + 1);
        false -> NewName
    end.

generate_suffix(Name, Suffix) ->
    if
        Suffix > 0 -> Suffix
    end.