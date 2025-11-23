-module(solution).
-export([is_match/2]).

is_match(S, P) ->
    case {S, P} of
        {[], []} -> true;
        {_, []} -> false;
        {[], _} ->
            case P of
                "*" ++ Rest -> is_match(S, Rest);
                _ ++ "*" ++ Rest -> is_match(S, Rest);
                _ -> false
            end;
        {[S1 | Ss], [P1 | Ps]} ->
            case Ps of
                "*" ++ RestPs ->
                    case is_match([S1 | Ss], RestPs) of
                        true -> true;
                        false ->
                            (P1 =:= $. orelse S1 =:= P1) andalso is_match(Ss, P)
                    end;
                _ ->
                    (P1 =:= $. orelse S1 =:= P1) andalso is_match(Ss, Ps)
            end
    end.