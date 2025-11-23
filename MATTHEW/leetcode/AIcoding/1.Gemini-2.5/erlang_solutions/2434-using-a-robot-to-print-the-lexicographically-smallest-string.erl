-module(solution).
-export([robotWithString/1]).

robotWithString(S) ->
    S_list = string:to_list(S),
    N = length(S_list),

    MinSuffixArray = gen_min_suffix_array(S_list, N),

    ResultPaperRev = process_string_recursive(S_list, [], [], MinSuffixArray, 0, N),

    string:from_list(lists:reverse(ResultPaperRev)).

gen_min_suffix_array(S_list, N) ->
    MinSuffixListRev = lists:foldl(
        fun(Char, {CurrentMin, Acc}) ->
            NewMin = min(Char, CurrentMin),
            {NewMin, [NewMin | Acc]}
        end,
        {$z + 1, []},
        lists:reverse(S_list)
    ),
    array:from_list(lists:reverse(MinSuffixListRev)).

process_string_recursive(S_list_remaining, Buffer, Paper_rev, MinSuffixArray, CurrentIdx, N) ->
    if S_list_remaining =:= [] ->
        empty_buffer_to_paper(Buffer, Paper_rev);
    true ->
        Char_s = hd(S_list_remaining),
        NewBuffer = [Char_s | Buffer],

        MinCharInRemainingS = 
            if CurrentIdx + 1 < N ->
                array:get(CurrentIdx + 1, MinSuffixArray);
            true ->
                $z + 1
            end,

        {UpdatedBuffer, UpdatedPaperRev} = pop_buffer_conditionally(NewBuffer, Paper_rev, MinCharInRemainingS),

        process_string_recursive(tl(S_list_remaining), UpdatedBuffer, UpdatedPaperRev, MinSuffixArray, CurrentIdx + 1, N)
    end.

pop_buffer_conditionally(Buffer, Paper_rev, MinCharInRemainingS) ->
    if Buffer =:= [] ->
        {Buffer, Paper_rev};
    true ->
        TopBuffer = hd(Buffer),
        if TopBuffer =< MinCharInRemainingS ->
            pop_buffer_conditionally(tl(Buffer), [TopBuffer | Paper_rev], MinCharInRemainingS);
        true ->
            {Buffer, Paper_rev}
        end
    end.

empty_buffer_to_paper(Buffer, Paper_rev) ->
    if Buffer =:= [] ->
        Paper_rev;
    true ->
        empty_buffer_to_paper(tl(Buffer), [hd(Buffer) | Paper_rev])
    end.