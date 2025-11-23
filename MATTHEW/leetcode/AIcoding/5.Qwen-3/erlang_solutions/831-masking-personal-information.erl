-module(solution).
-export([mask_pii/1]).

mask_pii(Email) ->
    case string:to_lower(Email) of
        Email when is_binary(Email) ->
            case string:split(Email, "@") of
                [Local, Domain] ->
                    MaskedLocal = mask_local(Local),
                    <<MaskedLocal/binary, "@", Domain/binary>>;
                _ ->
                    Email
            end;
        _ ->
            Email
    end.

mask_local(Local) ->
    case string:length(Local) of
        Len when Len =< 2 ->
            Local;
        _ ->
            First = string:sub_string(Local, 1, 1),
            Last = string:sub_string(Local, -1),
            Stars = string:copies("*", string:length(Local) - 2),
            <<First/binary, Stars/binary, Last/binary>>
    end.