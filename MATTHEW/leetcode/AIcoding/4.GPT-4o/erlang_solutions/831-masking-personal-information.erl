-module(solution).
-export([masking_personal_information/1]).

masking_personal_information(Info) ->
    case parse_info(Info) of
        {email, User, Domain} -> 
            format_email(User, Domain);
        {phone, Number} -> 
            format_phone(Number)
    end.

parse_info(Info) ->
    case string:split(Info, "@", all) of
        [User, Domain] -> {email, User, Domain};
        _ -> 
            {phone, extract_digits(Info)}
    end.

extract_digits(Info) ->
    lists:filter(fun(C) -> C >= $0 andalso C =< $9 end, unicode:characters_to_binary(Info)).

format_email(User, Domain) ->
    MaskedUser = string:substring(User, 1, 1) ++ "*****" ++ string:substring(User, -1),
    string:concat([MaskedUser, "@", string:lower(Domain)]).

format_phone(Number) ->
    case string:length(Number) of
        10 -> 
            "***-***-" ++ string:substring(Number, -4);
        _ -> 
            "+++ - *** - *** - " ++ string:substring(Number, -4)
    end.