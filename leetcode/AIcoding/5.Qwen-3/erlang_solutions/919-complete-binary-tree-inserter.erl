-module(solution).
-export([isCompleteTree/1]).

isCompleteTree(undefined) -> true;
isCompleteTree({tree, Left, Right}) ->
    is_complete(1, [1], {tree, Left, Right}).

is_complete(_, [], _) -> true;
is_complete(Index, [H | T], {tree, Left, Right}) ->
    if
        Index == H ->
            is_complete(Index + 1, T ++ get_children(Index, Left, Right), {tree, Left, Right});
        true ->
            false
    end.

get_children(Index, Left, Right) ->
    Children = [],
    case Left of
        undefined -> [];
        _ -> [2 * Index]
    end ++ case Right of
               undefined -> [];
               _ -> [2 * Index + 1]
           end.