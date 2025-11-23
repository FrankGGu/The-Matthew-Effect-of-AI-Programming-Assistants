-module(solution).
-export([maskPI/1]).

maskPI(S) ->
    case string:str(S, "@") of
        0 -> % No '@', it's a phone number
            mask_phone_number(S);
        _ -> % Contains '@', it's an email
            mask_email(S)
    end.

mask_email(S) ->
    LowerS = string:to_lower(S),
    [LocalPart, DomainPart] = string:tokens(LowerS, "@"),
    FirstChar = hd(LocalPart),
    LastChar = lists:last(LocalPart),
    MaskedLocalPart = [FirstChar] ++ "*****" ++ [LastChar],
    MaskedLocalPart ++ "@" ++ DomainPart.

mask_phone_number(S) ->
    Digits = lists:filter(fun(C) -> C >= $0 andalso C <= $9 end, S),
    Len = length(Digits),
    CountryCodePrefix = 
        case Len of
            10 -> "";
            11 -> "+*-";
            12 -> "+**-";
            13 -> "+***-"
        end,
    Last4Digits = lists:sublist(Digits, Len - 3, 4),
    CountryCodePrefix ++ "***-***-" ++ Last4Digits.