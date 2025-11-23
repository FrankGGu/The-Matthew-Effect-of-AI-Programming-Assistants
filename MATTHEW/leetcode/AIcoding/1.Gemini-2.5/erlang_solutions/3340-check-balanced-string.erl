-module(solution).
-export([is_valid/1]).

is_valid(S) ->
    check(S, []).

check([], []) ->
    true;
check([], _Stack) ->
    false;
check([Char|RestString], Stack) ->
    case Char of
        $( -> check(RestString, [Char|Stack]);
        $[ -> check(RestString, [Char|Stack]);
        ${ -> check(RestString, [Char|Stack]);
        $) ->
            case Stack of
                [$(|TailStack)] -> check(RestString, TailStack);
                _ -> false
            end;
        $] ->
            case Stack of
                [$[|TailStack)] -> check(RestString, TailStack);
                _ -> false
            end;
        $} ->
            case Stack of
                [${|TailStack)] -> check(RestString, TailStack);
                _ -> false
            end;
        _ ->
            false
    end.