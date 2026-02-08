-module(solution).
-export([longest_special_path/1]).

-record(node, {val, children = []}).

longest_special_path(Root) ->
    case Root of
        nil -> 0;
        _ -> 
            {Val, Children} = Root#node,
            longest_special_path_helper(Children, Val, 0)
    end.

longest_special_path_helper([], _, Length) -> Length;
longest_special_path_helper(Children, PrevVal, Length) ->
    lists:max([ longest_special_path_helper(Child#node.children, Child#node.val, 
        if 
            Child#node.val /= PrevVal -> Length + 1;
            true -> Length
        end) || Child <- Children ]).