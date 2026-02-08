-module(solution).
-export([count_substrings/1]).

-spec update_counts_add(char(), integer(), integer(), integer()) -> {integer(), integer(), integer()}.
update_counts_add(Char, Ca, Cb, Cc) ->
    case Char of
        $a -> {Ca + 1, Cb, Cc};
        $b -> {Ca, Cb + 1, Cc};
        $c -> {Ca, Cb, Cc + 1};
        _ -> {Ca, Cb, Cc}
    end.

-spec update_counts_remove(char(), integer(), integer(), integer()) -> {integer(), integer(), integer()}.
update_counts_remove(Char, Ca, Cb, Cc) ->
    case Char of
        $a -> {Ca - 1, Cb, Cc};
        $b -> {Ca, Cb - 1, Cc};
        $c -> {Ca, Cb, Cc - 1};
        _ -> {Ca, Cb, Cc}
    end.

-spec shrink_loop(array:array(), integer(), integer(), integer(), integer(), integer()) -> {integer(), integer(), integer(), integer(), integer()}.
shrink_loop(S_array, LeftIdx, Ca, Cb, Cc, Ans) ->
    if
        Ca >= 1 andalso Cb >= 1 andalso Cc >= 1 ->
            %% Condition met: current window S[LeftIdx..RightIdx] is valid.
            %% All substrings S[0..RightIdx], S[1..RightIdx], ..., S[LeftIdx..RightIdx]
            %% are valid. There are (LeftIdx + 1) such substrings.
            NewAns = Ans + (LeftIdx + 1),
            LeftChar = array:get(LeftIdx, S_array),
            {NextCa, NextCb, NextCc} = update_counts_remove(LeftChar, Ca, Cb, Cc),
            NextLeftIdx = LeftIdx + 1,
            shrink_loop(S_array, NextLeftIdx, NextCa, NextCb, NextCc, NewAns);
        true ->
            %% Condition not met, stop shrinking
            {LeftIdx, Ca, Cb, Cc, Ans}
    end.

-spec count_substrings(string()) -> integer().
count_substrings(S) ->
    S_list = string:to_list(S),
    S_array = array:from_list(S_list),
    N = array:size(S_array),

    {_FinalLeftIdx, _FinalCa, _FinalCb, _FinalCc, FinalAns} =
        lists:foldl(
            fun(RightIdx, {LeftIdx, Ca, Cb, Cc, Ans}) ->
                %% Add current char (S[RightIdx]) to window
                Char = array:get(RightIdx, S_array),
                {NewCa, NewCb, NewCc} = update_counts_add(Char, Ca, Cb, Cc),

                %% Shrink window from left while condition is met
                %% This helper function will return the new state after all possible shrinks
                shrink_loop(S_array, LeftIdx, NewCa, NewCb, NewCc, Ans)
            end,
            {0, 0, 0, 0, 0}, %% Initial state: {LeftIdx, Ca, Cb, Cc, Ans}
            lists:seq(0, N - 1) %% Iterate RightIdx from 0 to N-1
        ),
    FinalAns.