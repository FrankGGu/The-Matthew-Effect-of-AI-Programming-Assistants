-module(solution).
-export([string_without_aaa_or_bbb/2]).

string_without_aaa_or_bbb(A, B) ->
    string_without_aaa_or_bbb_impl(A, B, [], ' ', 0).

string_without_aaa_or_bbb_impl(0, 0, Acc, _, _) ->
    lists:reverse(Acc);
string_without_aaa_or_bbb_impl(A, B, Acc, LastChar, ConsecutiveCount) ->
    CanAppendA = (A > 0) and ((LastChar =/= $a) or (ConsecutiveCount < 2)),
    CanAppendB = (B > 0) and ((LastChar =/= $b) or (ConsecutiveCount < 2)),

    AppendChar =
        if
            CanAppendA and CanAppendB ->
                if
                    A >= B -> $a;
                    true -> $b
                end;
            CanAppendA -> $a;
            CanAppendB -> $b;
            true -> % This branch should theoretically not be reached if A+B > 0,
                    % as the problem guarantees a solution exists.
                    % If it were reached, it would mean no valid move is possible.
                    % For Erlang's 'if' completeness, a default is needed.
                    % It will not affect correctness under problem constraints.
                    $a 
        end,

    NewConsecutiveCount =
        if
            AppendChar == LastChar -> ConsecutiveCount + 1;
            true -> 1
        end,

    if
        AppendChar == $a ->
            string_without_aaa_or_bbb_impl(A - 1, B, [$a | Acc], $a, NewConsecutiveCount);
        true -> % AppendChar == $b
            string_without_aaa_or_bbb_impl(A, B - 1, [$b | Acc], $b, NewConsecutiveCount)
    end.