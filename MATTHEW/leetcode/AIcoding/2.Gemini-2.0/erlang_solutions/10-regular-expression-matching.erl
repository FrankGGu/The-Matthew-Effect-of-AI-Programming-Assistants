-module(solution).
-export([is_match/2]).

is_match(S, P) ->
    is_match_helper(S, 0, P, 0).

is_match_helper(S, Si, P, Pi) ->
    case {Si >= length(S), Pi >= length(P)} of
        {true, true} -> true;
        {true, false} ->
            case P of
                [_|_] ->
                    case Pi + 1 < length(P) andalso element(Pi+2, list_to_tuple(string:characters(P))) == $* of
                        true -> is_match_helper(S, Si, P, Pi + 2);
                        false -> false
                    end;
                _ -> false
            end;
        {false, true} -> false;
        {false, false} ->
            case {element(Pi+1, list_to_tuple(string:characters(P))), Pi + 1 < length(P) andalso element(Pi+2, list_to_tuple(string:characters(P))) == $* } of
                {C, true} ->
                    case {C == element(Si+1, list_to_tuple(string:characters(S))), C == $.} of
                        {true, _} ->
                            is_match_helper(S, Si + 1, P, Pi) orelse is_match_helper(S, Si, P, Pi + 2);
                        {false, true} ->
                            is_match_helper(S, Si + 1, P, Pi) orelse is_match_helper(S, Si, P, Pi + 2);
                        {false, false} ->
                            is_match_helper(S, Si, P, Pi + 2)
                    end;
                {C, false} ->
                    case {C == element(Si+1, list_to_tuple(string:characters(S))), C == $.} of
                        {true, _} ->
                            is_match_helper(S, Si + 1, P, Pi + 1);
                        {false, true} ->
                            is_match_helper(S, Si + 1, P, Pi + 1);
                        {false, false} ->
                            false
                    end
            end
    end.