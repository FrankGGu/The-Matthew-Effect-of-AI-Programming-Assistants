-module(solution).
-export([longest_valid_parentheses/1]).

longest_valid_parentheses(S) ->
    Chars = string:to_list(S),
    solve(Chars, 0, [-1], 0).

solve([], _Index, _Stack, MaxLen) ->
    MaxLen;
solve([H|T], Index, Stack, MaxLen) ->
    case H of
        $( ->
            solve(T, Index + 1, [Index|Stack], MaxLen);
        $) ->
            case Stack of
                [_TopIndex|[]] ->
                    solve(T, Index + 1, [Index], MaxLen);
                [_TopIndex|RestStack] ->
                    NewMaxLen = max(MaxLen, Index - hd(RestStack)),
                    solve(T, Index + 1, RestStack, NewMaxLen)
            end
    end.