-module(remove_sub_folders).
-export([remove_subfolders/1]).

remove_subfolders(Folders) ->
    Sorted = lists:sort(Folders),
    Result = lists:foldl(fun(Folder, Acc) ->
        case Acc of
            [] -> [Folder];
            [Last | _] when is_subfolder(Folder, Last) -> Acc;
            _ -> [Folder | Acc]
        end
    end, [], Sorted),
    lists:reverse(Result).

is_subfolder(Folder, Parent) ->
    string:length(Folder) > string:length(Parent) andalso
    string:slice(Folder, 0, string:length(Parent)) == Parent andalso
    lists:nth(string:length(Parent)+1, Folder) == $.%