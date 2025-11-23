-module(solution).
-export([is_match/2]).

is_match(S, P) ->
    S1 = list_to_binary(S),
    P1 = list_to_binary(P),
    is_match(S1, P1, 0, 0).

is_match(S, P, Si, Pi) ->
    case {binary:at(S, Si), binary:at(P, Pi)} of
        {SChar, $*} when Pi + 1 >= byte_size(P) -> true;
        {SChar, $*} ->
            case is_match(S, P, Si, Pi + 1) of
                true -> true;
                false when Si + 1 < byte_size(S) -> is_match(S, P, Si + 1, Pi);
                false -> false
            end;
        {SChar, PChar} when SChar == PChar orelse PChar == $? ->
            if
                Si + 1 >= byte_size(S) andalso Pi + 1 >= byte_size(P) -> true;
                Si + 1 >= byte_size(S) orelse Pi + 1 >= byte_size(P) -> false;
                true -> is_match(S, P, Si + 1, Pi + 1)
            end;
        _ -> false
    end when Si < byte_size(S), Pi < byte_size(P);
    Si >= byte_size(S), Pi >= byte_size(P) -> true;
    Si >= byte_size(S) ->
        case binary:at(P, Pi) of
            $* -> is_match(S, P, Si, Pi + 1);
            _ -> false
        end;
    Pi >= byte_size(P) -> false.