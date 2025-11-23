-module(solution).
-export([numUniqueEmails/1]).

numUniqueEmails(Emails) ->
    EmailSet = lists:foldl(fun(Email, Acc) ->
        NormalizedEmail = normalize(Email),
        maps:put(NormalizedEmail, true, Acc)
    end, maps:new(), Emails),
    maps:size(EmailSet).

normalize(Email) ->
    [Local, Domain] = string:split(Email, "@"),
    LocalNormalized = normalize_local(Local),
    LocalNormalized ++ <<"@"/binary>>, Domain.

normalize_local(Local) ->
    case string:split(Local, "+") of
        [Base | _] -> 
            Base =:= string:replace(Base, ".", "", all)
        _ -> 
            Local
    end.