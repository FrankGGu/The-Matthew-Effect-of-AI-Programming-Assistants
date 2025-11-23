-module(solution).
-export([remove_subfolders/1]).

remove_subfolders(Folders) ->
    Sorted = lists:sort(Folders),
    remove_subfolders(Sorted, []).

remove_subfolders([], Acc) ->
    lists:reverse(Acc);
remove_subfolders([H | T], []) ->
    remove_subfolders(T, [H]);
remove_subfolders([H | T], [Last | _] = Acc) ->
    case is_subfolder(Last, H) of
        true -> remove_subfolders(T, Acc);
        false -> remove_subfolders(T, [H | Acc])
    end.

is_subfolder(Parent, Child) ->
    case string:prefix(Child, Parent) of
        nomatch -> false;
        Rest -> 
            case Rest of
                [] -> false;
                [$/ | _] -> true;
                _ -> false
            end
    end.