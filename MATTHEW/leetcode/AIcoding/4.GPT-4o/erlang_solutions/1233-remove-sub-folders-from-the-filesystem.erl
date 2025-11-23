-module(solution).
-export([remove_subfolders/1]).

remove_subfolders(Folders) ->
    Folders1 = lists:sort(Folders),
    remove_subfolders_helper(Folders1, []).

remove_subfolders_helper([], Acc) ->
    lists:reverse(Acc);
remove_subfolders_helper([H | T], Acc) ->
    case lists:any(fun(X) -> is_prefix(X, H) end, Acc) of
        true -> remove_subfolders_helper(T, Acc);
        false -> remove_subfolders_helper(T, [H | Acc])
    end.

is_prefix(Prefix, String) ->
    case string:prefix(String, Prefix) of
        true -> 
            case string:at(String, length(Prefix)) of
                $/ -> true;
                _ -> false
            end;
        false -> false
    end.