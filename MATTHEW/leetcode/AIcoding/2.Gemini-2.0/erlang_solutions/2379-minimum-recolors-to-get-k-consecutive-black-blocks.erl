-module(minimum_recolors).
-export([minimum_recolors/2]).

minimum_recolors(Blocks, K) ->
    Len = length(Blocks),
    minimum_recolors(Blocks, K, 0, Len - K + 1, Len, K).

minimum_recolors(Blocks, K, Start, End, Len, K) ->
    case Start > End - 1 of
        true ->
            infinity;
        false ->
            W_count = count_white(Blocks, Start, Start + K - 1),
            min(W_count, minimum_recolors(Blocks, K, Start + 1, End, Len, K))
    end.

count_white(Blocks, Start, End) ->
    count_white(Blocks, Start, End, 0).

count_white(Blocks, Start, End, Acc) ->
    case Start > End of
        true ->
            Acc;
        false ->
            case lists:nth(Start + 1, Blocks) of
                $W ->
                    count_white(Blocks, Start + 1, End, Acc + 1);
                _ ->
                    count_white(Blocks, Start + 1, End, Acc)
            end
    end.

infinity() ->
    100001.