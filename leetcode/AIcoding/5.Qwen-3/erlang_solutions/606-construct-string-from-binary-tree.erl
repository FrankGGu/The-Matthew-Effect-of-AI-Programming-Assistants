-module(solution).
-export([tree_to_string/1]).

tree_to_string(nil) -> "";
tree_to_string({Val, Left, Right}) ->
    ValStr = integer_to_list(Val),
    LeftStr = tree_to_string(Left),
    RightStr = tree_to_string(Right),
    case {LeftStr, RightStr} of
        {"", ""} -> ValStr;
        {"", _} -> ValStr ++ "(" ++ RightStr ++ ")";
        {_, ""} -> ValStr ++ "(" ++ LeftStr ++ ")";
        _ -> ValStr ++ "(" ++ LeftStr ++ ")" ++ "(" ++ RightStr ++ ")"
    end.