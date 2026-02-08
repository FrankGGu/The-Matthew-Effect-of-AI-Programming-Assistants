-module(crawler_log_folder).
-export([count_subfolders_in_root/1]).

count_subfolders_in_root(Paths) ->
    count_subfolders(Paths, []).

count_subfolders([], _) -> 0;
count_subfolders([H | T], Visited) ->
    case lists:member(H, Visited) of
        true -> count_subfolders(T, Visited);
        false ->
            case string:tokens(H, "/") of
                [_, _ | _] -> 
                    NewVisited = [H | Visited],
                    1 + count_subfolders(T, NewVisited);
                _ -> 
                    count_subfolders(T, Visited)
            end
    end.