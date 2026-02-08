-module(solution).
-export([remove_invalid_parentheses/1]).

remove_invalid_parentheses(S) ->
    {Left, Right} = count_remove(S),
    Result = sets:new(),
    remove(S, 0, 0, Left, Right, [], Result),
    sets:to_list(Result).

count_remove(S) ->
    count_remove(S, 0, 0, 0, 0).

count_remove([], Left, Right, LRemove, RRemove) ->
    {LRemove + Left, RRemove + Right};
count_remove([$( | T], Left, Right, LRemove, RRemove) ->
    count_remove(T, Left + 1, Right, LRemove, RRemove);
count_remove([$) | T], Left, Right, LRemove, RRemove) when Left > Right ->
    count_remove(T, Left, Right + 1, LRemove, RRemove);
count_remove([$) | T], Left, Right, LRemove, RRemove) ->
    count_remove(T, Left, Right, LRemove, RRemove + 1);
count_remove([_ | T], Left, Right, LRemove, RRemove) ->
    count_remove(T, Left, Right, LRemove, RRemove).

remove(S, Index, Count, LeftRem, RightRem, Path, Result) when Index == length(S) ->
    if
        LeftRem == 0, RightRem == 0, Count == 0 ->
            sets:add_element(lists:reverse(Path), Result);
        true ->
            Result
    end;
remove([H | T], Index, Count, LeftRem, RightRem, Path, Result) ->
    case H of
        $( ->
            if
                LeftRem > 0 ->
                    NewResult = remove(T, Index + 1, Count, LeftRem - 1, RightRem, Path, Result),
                    remove(T, Index + 1, Count + 1, LeftRem, RightRem, [H | Path], NewResult);
                true ->
                    remove(T, Index + 1, Count + 1, LeftRem, RightRem, [H | Path], Result)
            end;
        $) ->
            if
                RightRem > 0 ->
                    NewResult = remove(T, Index + 1, Count, LeftRem, RightRem - 1, Path, Result),
                    if
                        Count > 0 ->
                            remove(T, Index + 1, Count - 1, LeftRem, RightRem, [H | Path], NewResult);
                        true ->
                            NewResult
                    end;
                Count > 0 ->
                    remove(T, Index + 1, Count - 1, LeftRem, RightRem, [H | Path], Result);
                true ->
                    Result
            end;
        _ ->
            remove(T, Index + 1, Count, LeftRem, RightRem, [H | Path], Result)
    end.