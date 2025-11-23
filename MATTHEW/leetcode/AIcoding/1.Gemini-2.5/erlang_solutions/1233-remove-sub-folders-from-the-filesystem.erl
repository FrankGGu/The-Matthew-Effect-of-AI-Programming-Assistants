-module(solution).
-export([removeSubfolders/1]).

removeSubfolders(Folders) ->
    SortedFolders = lists:sort(Folders),
    process_folders(SortedFolders, []).

process_folders([], Acc) ->
    lists:reverse(Acc);
process_folders([CurrentFolder | Rest], []) ->
    process_folders(Rest, [CurrentFolder]);
process_folders([CurrentFolder | Rest], [LastRoot | _] = Acc) ->
    case is_subfolder(CurrentFolder, LastRoot) of
        true ->
            process_folders(Rest, Acc);
        false ->
            process_folders(Rest, [CurrentFolder | Acc])
    end.

is_subfolder(Path, Parent) ->
    case string:prefix(Path, Parent) of
        {true, Suffix} ->
            case Suffix of
                "/" ++ _ -> true;
                _ -> false
            end;
        false ->
            false
    end.