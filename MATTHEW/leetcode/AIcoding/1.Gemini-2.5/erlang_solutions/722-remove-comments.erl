-module(solution).
-export([removeComments/1]).

removeComments(Source) ->
    lists:reverse(
        remove_comments_internal(Source, normal, [], [])
    ).

remove_comments_internal([], normal, [], Acc) ->
    Acc;
remove_comments_internal([], normal, CurrentLineBuffer, Acc) ->
    [lists:reverse(CurrentLineBuffer) | Acc];
remove_comments_internal([], in_block_comment, _CurrentLineBuffer, Acc) ->
    Acc.

remove_comments_internal([Line | Rest], State, CurrentLineBuffer, Acc) ->
    {NewState, TempLineBuffer, LineCompleted} = process_chars(Line, State, CurrentLineBuffer),
    case LineCompleted of
        true ->
            FinalLine = lists:reverse(TempLineBuffer),
            case FinalLine of
                [] ->
                    remove_comments_internal(Rest, NewState, [], Acc);
                _ ->
                    remove_comments_internal(Rest, NewState, [], [FinalLine | Acc])
            end;
        false ->
            remove_comments_internal(Rest, NewState, TempLineBuffer, Acc)
    end.

process_chars(Chars, State, CurrentLineBuffer) ->
    process_chars_recursive(Chars, State, CurrentLineBuffer, []).

process_chars_recursive([], normal, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    {normal, CurrentPhysicalLineAccumulator ++ CurrentLogicalLineBuffer, true};
process_chars_recursive([], in_block_comment, CurrentLogicalLineBuffer, _CurrentPhysicalLineAccumulator) ->
    {in_block_comment, CurrentLogicalLineBuffer, false};

process_chars_recursive([$/,$* | Rest], normal, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    process_chars_recursive(Rest, in_block_comment, CurrentLogicalLineBuffer ++ CurrentPhysicalLineAccumulator, []);
process_chars_recursive([$/,$* | Rest], in_block_comment, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    process_chars_recursive(Rest, in_block_comment, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator);

process_chars_recursive([$*,$ / | Rest], in_block_comment, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    process_chars_recursive(Rest, normal, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator);
process_chars_recursive([$*,$ / | Rest], normal, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    process_chars_recursive(Rest, normal, CurrentLogicalLineBuffer, [$*,$ / | CurrentPhysicalLineAccumulator]);

process_chars_recursive([$/,$ / | _Rest], normal, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    {normal, CurrentPhysicalLineAccumulator ++ CurrentLogicalLineBuffer, true};
process_chars_recursive([$/,$ / | Rest], in_block_comment, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    process_chars_recursive(Rest, in_block_comment, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator);

process_chars_recursive([Char | Rest], normal, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    process_chars_recursive(Rest, normal, CurrentLogicalLineBuffer, [Char | CurrentPhysicalLineAccumulator]);
process_chars_recursive([_Char | Rest], in_block_comment, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator) ->
    process_chars_recursive(Rest, in_block_comment, CurrentLogicalLineBuffer, CurrentPhysicalLineAccumulator).