-module(solution).
-export([find_duplicate_subtrees/1]).

-record(node, {val, left = none, right = none}).

find_duplicate_subtrees(Root) ->
    {_, Result} = find_duplicates(Root, #{}, []),
    Result.

find_duplicates(none, Seen, Acc) ->
    {Seen, Acc};
find_duplicates(#node{val=Val, left=Left, right=Right}, Seen, Acc) ->
    Subtree = io_lib:format("~p,~p,~p", [Val, find_duplicates(Left, Seen, Acc), find_duplicates(Right, Seen, Acc)]),
    case maps:is_key(Subtree, Seen) of
        true ->
            find_duplicates(Left, Seen, [#node{val=Val, left=Left, right=Right} | Acc]);
        false ->
            Seen1 = maps:put(Subtree, 1, Seen),
            find_duplicates(Left, Seen1, Acc)
    end,
    find_duplicates(Right, Seen, Acc).