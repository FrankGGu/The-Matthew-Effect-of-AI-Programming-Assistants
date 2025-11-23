-module(shortest_subarray).
-export([shortest_subarray/2]).

shortest_subarray(A, K) ->
    shortest_subarray_helper(A, K, []).

shortest_subarray_helper(A, K, Q) ->
    shortest_subarray_helper(A, K, Q, 0, 0).

shortest_subarray_helper([], K, Q, Len, MinLen) ->
    if Q == [] then
        if MinLen == 0 then
            -1
        else
            MinLen
        end
    else
        if MinLen == 0 then
            -1
        else
            MinLen
        end
    end;
shortest_subarray_helper([H|T], K, Q, Len, MinLen) ->
    {NewQ, NewLen, NewMinLen} = process_element(H, K, Q, Len, MinLen),
    shortest_subarray_helper(T, K, NewQ, NewLen, NewMinLen).

process_element(H, K, Q, Len, MinLen) ->
    NewQ = add_to_queue(H, Q),
    NewLen = Len + 1,
    {FinalQ, FinalLen, FinalMinLen} = remove_from_queue(NewQ, K, NewLen, MinLen),
    {FinalQ, FinalLen, FinalMinLen}.

add_to_queue(H, []) ->
    [{H, 0}];
add_to_queue(H, Q) ->
    LastSum = element(2, lists:last(Q)),
    Q ++ [{H, LastSum + H}].

remove_from_queue(Q, K, Len, MinLen) ->
    remove_from_queue(Q, K, Len, MinLen, 0).

remove_from_queue([], K, Len, MinLen, CurrMinLen) ->
    {[], Len, CurrMinLen};
remove_from_queue([{FirstH, FirstSum}|RestQ], K, Len, MinLen, CurrMinLen) ->
    if FirstSum >= K then
        NewMinLen = case MinLen of
            0 -> Len;
            _ -> min(Len, MinLen)
        end,
        remove_from_queue(RestQ, K, Len - 1, NewMinLen, NewMinLen)
    else
        remove_min(RestQ, K, Len, MinLen, CurrMinLen, [{FirstH, FirstSum}]).

remove_min(Q, K, Len, MinLen, CurrMinLen, Acc) ->
    case Q of
        [] -> {Acc, Len, CurrMinLen};
        _ -> {Acc ++ Q, Len, CurrMinLen}
    end.