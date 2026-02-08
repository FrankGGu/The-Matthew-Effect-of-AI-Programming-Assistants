-module(small_string_starting_from_leaf).
-export([smallestFromLeaf/1]).

smallestFromLeaf(Null) when Null =:= null -> [];
smallestFromLeaf({Val, Left, Right}) ->
    LeftStr = smallestFromLeaf(Left),
    RightStr = smallestFromLeaf(Right),
    Char = lists:flatten(io_lib:format("~p", [Val + $a])),
    case {LeftStr, RightStr} of
        {[], []} -> Char;
        {[], _} -> lists:min([Char ++ RightStr]);
        {_, []} -> lists:min([Char ++ LeftStr]);
        _ -> lists:min([Char ++ LeftStr, Char ++ RightStr])
    end.