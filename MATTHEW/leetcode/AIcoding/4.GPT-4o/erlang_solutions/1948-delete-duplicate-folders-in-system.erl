-module(solution).
-export([deleteDuplicateFolders/1]).

deleteDuplicateFolders(Folders) ->
    Folders1 = lists:map(fun(Folder) -> {Folder, folder_hash(Folder)} end, Folders),
    UniqueHashes = dict:from_list(lists:foldl(fun({Folder, Hash}, Acc) -> 
        case dict:find(Hash, Acc) of
            {ok, _} -> Acc;
            _ -> dict:store(Hash, Folder, Acc)
        end
    end, dict:new(), Folders1)),
    lists:map(fun({_, Folder}) -> Folder end, dict:to_list(UniqueHashes)).

folder_hash(Folder) ->
    lists:foldl(fun(X, Acc) -> Acc + binary_to_list(X) end, 0, Folder).