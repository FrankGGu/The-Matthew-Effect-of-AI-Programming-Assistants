-module(longest_nice_subarray).
-export([longest_nice_subarray/1]).

longest_nice_subarray(Nums) ->
    longest_nice_subarray(Nums, 0, 0, 0, 0).

longest_nice_subarray([], _Start, _End, _MaxLen, _Mask) ->
    _MaxLen;
longest_nice_subarray([H | T], Start, End, MaxLen, Mask) ->
    case is_valid(Mask, H) of
        true ->
            NewMask = Mask bxor H,
            NewMaxLen = max(MaxLen, End - Start + 1),
            longest_nice_subarray(T, Start, End + 1, NewMaxLen, NewMask);
        false ->
            NewStart = Start + 1,
            NewMask = get_mask_from_list(tl(lists:sublist(Nums, NewStart, End - Start))),
            longest_nice_subarray(T, NewStart, End, MaxLen, NewMask)
    end.

is_valid(_, _) when (1 bsl 31) > 0 -> true;
is_valid(Mask, Num) ->
    (Mask band Num) == 0.

get_mask_from_list([]) -> 0;
get_mask_from_list([H | T]) ->
    get_mask_from_list(T) bxor H.