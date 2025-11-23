-spec longest_common_prefix(K :: integer(), strs :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
longest_common_prefix(K, Strs) ->
    case Strs of
        [] -> <<>>;
        _ ->
            MinLen = lists:min([byte_size(S) || S <- Strs]),
            MaxLen = lists:max([byte_size(S) || S <- Strs]),
            binary:part(hd(Strs), 0, find_max_len(Strs, K, 0, MinLen))
    end.

find_max_len(Strs, K, Low, High) ->
    if
        Low > High -> High;
        true ->
            Mid = (Low + High) div 2,
            case is_common_prefix(Strs, Mid, K) of
                true -> find_max_len(Strs, K, Mid + 1, High);
                false -> find_max_len(Strs, K, Low, Mid - 1)
            end
    end.

is_common_prefix(Strs, Len, K) ->
    Prefix = binary:part(hd(Strs), 0, Len),
    Count = lists:foldl(fun(S, Acc) ->
        case binary:match(S, Prefix) of
            {0, _} -> Acc + 1;
            _ -> Acc
        end
    end, 0, Strs),
    Count >= length(Strs) - K.