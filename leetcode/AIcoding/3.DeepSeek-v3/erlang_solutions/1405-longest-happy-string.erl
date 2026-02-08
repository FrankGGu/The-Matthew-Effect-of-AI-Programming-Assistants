-spec longest_diverse_string(A :: integer(), B :: integer(), C :: integer()) -> unicode:unicode_binary().
longest_diverse_string(A, B, C) ->
    solve(A, B, C, $a, $b, $c).

solve(A, B, C, X, Y, Z) when A >= B andalso A >= C andalso A > 0 ->
    case can_append(X, X, A, B, C) of
        true -> <<X, (solve(A - 1, B, C, X, Y, Z))/binary>>;
        false -> <<>>
    end;
solve(A, B, C, X, Y, Z) when B >= A andalso B >= C andalso B > 0 ->
    case can_append(Y, Y, B, A, C) of
        true -> <<Y, (solve(A, B - 1, C, Y, X, Z))/binary>>;
        false -> <<>>
    end;
solve(A, B, C, X, Y, Z) when C >= A andalso C >= B andalso C > 0 ->
    case can_append(Z, Z, C, A, B) of
        true -> <<Z, (solve(A, B, C - 1, Z, X, Y))/binary>>;
        false -> <<>>
    end;
solve(_, _, _, _, _, _) -> <<>>.

can_append(Last, Prev, Count, Other1, Other2) ->
    case Count > Other1 + Other2 + 1 of
        true -> false;
        false ->
            case {Last, Prev} of
                {X, X} -> Count =< (Other1 + Other2) * 2 + 2;
                _ -> true
            end
    end.