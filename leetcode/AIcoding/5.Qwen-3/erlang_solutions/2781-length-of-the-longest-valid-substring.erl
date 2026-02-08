-module(longest_valid_substring).
-export([longest_valid_parentheses/1]).

longest_valid_parentheses(S) ->
    longest_valid_parentheses(S, 0, 0, 0, 0).

longest_valid_parentheses([], _, _, Max, _) ->
    Max;
longest_valid_parentheses([H | T], Left, Right, Max, Cur) ->
    case H of
        $() ->
            NewLeft = Left + 1,
            NewRight = Right,
            if
                NewLeft == NewRight ->
                    NewCur = Cur + 2;
                true ->
                    NewCur = Cur
            end,
            NewMax = max(Max, NewCur),
            longest_valid_parentheses(T, NewLeft, NewRight, NewMax, NewCur);
        $) ->
            NewLeft = Left,
            NewRight = Right + 1,
            if
                NewLeft == NewRight ->
                    NewCur = Cur + 2;
                true ->
                    NewCur = Cur
            end,
            NewMax = max(Max, NewCur),
            longest_valid_parentheses(T, NewLeft, NewRight, NewMax, NewCur)
    end.