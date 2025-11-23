-module(recover_from_preorder).
-export([recover_from_preorder/1]).

-spec recover_from_preorder(string()) -> tree().
recover_from_preorder(S) ->
    {Root, _} = recover_from_preorder_helper(S, 0),
    Root.

recover_from_preorder_helper(S, D) ->
    case parse_node(S, D) of
        none ->
            {null, S};
        {Val, Rest} ->
            {Left, Rest1} = recover_from_preorder_helper(Rest, D + 1),
            {Right, Rest2} = recover_from_preorder_helper(Rest1, D + 1),
            {{Val, Left, Right}, Rest2}
    end.

parse_node(S, D) ->
    Dots = lists:seq(1, D),
    Prefix = lists:duplicate(D, $-),
    case string:prefix(S, Prefix) of
        true ->
            Rest = string:sub(S, D + 1, length(S) - D),
            case string:tokens(Rest, "-") of
                [Num | _] ->
                    try
                        Value = list_to_integer(Num),
                        {Value, Rest}
                    catch
                        _:_ ->
                            none
                    end;
                [] ->
                    none
            end;
        false ->
            none
    end.