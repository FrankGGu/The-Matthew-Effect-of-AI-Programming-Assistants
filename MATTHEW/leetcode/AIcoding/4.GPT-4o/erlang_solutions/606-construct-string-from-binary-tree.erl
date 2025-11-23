-module(solution).
-export([tree2str/1]).

-type tree() :: none | {Node, tree(), tree()}.

tree2str(nil) -> "";
tree2str({Node, Left, Right}) ->
    NodeStr = integer_to_list(Node),
    LeftStr = tree2str(Left),
    RightStr = tree2str(Right),
    case {LeftStr, RightStr} of
        {"", ""} -> NodeStr;
        {"", _} -> NodeStr ++ "(" ++ RightStr ++ ")";
        {_, ""} -> NodeStr ++ "(" ++ LeftStr ++ ")";
        {_, _} -> NodeStr ++ "(" ++ LeftStr ++ ")" ++ "(" ++ RightStr ++ ")";
    end.