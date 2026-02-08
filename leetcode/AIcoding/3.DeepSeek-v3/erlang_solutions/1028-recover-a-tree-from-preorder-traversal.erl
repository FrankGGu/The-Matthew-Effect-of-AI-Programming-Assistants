-module(recover_tree).
-export([recoverFromPreorder/1]).

recoverFromPreorder(S) ->
    {Tree, _} = parse(S, 0),
    Tree.

parse([], _) -> {nil, []};
parse(S, Depth) ->
    {Val, Rest} = extract_val(S),
    {Left, Rest1} = case Rest of
        [] -> {nil, []};
        _ -> 
            {D, Rest2} = extract_depth(Rest),
            if 
                D == Depth + 1 -> parse(Rest2, Depth + 1);
                true -> {nil, Rest}
            end
    end,
    {Right, Rest3} = case Rest1 of
        [] -> {nil, []};
        _ -> 
            {D1, Rest4} = extract_depth(Rest1),
            if 
                D1 == Depth + 1 -> parse(Rest4, Depth + 1);
                true -> {nil, Rest1}
            end
    end,
    {{Val, Left, Right}, Rest3}.

extract_val(S) ->
    extract_val(S, []).

extract_val([], Acc) -> {list_to_integer(lists:reverse(Acc)), []};
extract_val([$- | Rest], []) -> extract_val(Rest, [$-]);
extract_val([$- | Rest], Acc) -> {list_to_integer(lists:reverse(Acc)), [$- | Rest]};
extract_val([C | Rest], Acc) -> extract_val(Rest, [C | Acc]).

extract_depth(S) ->
    extract_depth(S, 0).

extract_depth([$- | Rest], Count) -> extract_depth(Rest, Count + 1);
extract_depth(Rest, Count) -> {Count, Rest}.