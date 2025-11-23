-module(solution).
-export([tree2str/1]).

-record(treenode, {val, left=null, right=null}).

tree2str(null) ->
    "";
tree2str(#treenode{val = Val, left = Left, right = Right}) ->
    ValStr = integer_to_list(Val),
    case {Left, Right} of
        {null, null} ->
            ValStr;
        {_, null} ->
            LeftStr = tree2str(Left),
            ValStr ++ "(" ++ LeftStr ++ ")";
        {null, _} ->
            RightStr = tree2str(Right),
            ValStr ++ "()" ++ "(" ++ RightStr ++ ")";
        {_, _} ->
            LeftStr = tree2str(Left),
            RightStr = tree2str(Right),
            ValStr ++ "(" ++ LeftStr ++ ")" ++ "(" ++ RightStr ++ ")"
    end.