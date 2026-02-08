-module(solution).
-export([longest_special_path/1]).

-record(node, {val, children = []}).

longest_special_path(Tree) ->
    case Tree of
        [] -> 0;
        _ -> longest_special_path(Tree, undefined, 0)
    end.

longest_special_path([], _PrevVal, MaxLen) -> MaxLen;
longest_special_path([H | T], PrevVal, MaxLen) ->
    NewMaxLen = case PrevVal of
        undefined -> longest_special_path(H#node.children, H#node.val, MaxLen + 1);
        _ when H#node.val /= PrevVal -> longest_special_path(H#node.children, H#node.val, MaxLen + 1);
        _ -> longest_special_path(H#node.children, H#node.val, MaxLen)
    end,
    longest_special_path(T, PrevVal, NewMaxLen).