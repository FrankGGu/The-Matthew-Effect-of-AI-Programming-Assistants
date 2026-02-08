-module(solution).
-export([numUniqueEmails/1]).

numUniqueEmails(Emails) ->
    UniqueEmailsSet = lists:foldl(
        fun(Email, AccSet) ->
            CanonicalEmail = process_email(Email),
            sets:add_element(CanonicalEmail, AccSet)
        end,
        sets:new(),
        Emails
    ),
    sets:size(UniqueEmailsSet).

process_email(Email) ->
    [LocalName, DomainName] = string:split(Email, "@"),

    LocalNameWithoutPlus = 
        case string:find(LocalName, "+") of
            {match, StartIndex, _Length} ->
                string:substr(LocalName, 1, StartIndex - 1);
            nomatch ->
                LocalName
        end,

    LocalNameCleaned = string:replace(LocalNameWithoutPlus, ".", "", all),

    LocalNameCleaned ++ "@" ++ DomainName.