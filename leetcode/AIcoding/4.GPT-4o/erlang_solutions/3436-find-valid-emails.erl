-module(solution).
-export([numUniqueEmails/1]).

numUniqueEmails(Emails) ->
    Emails
    |> lists:map(fun Email -> parse_email(Email) end)
    |> lists:usort()
    |> length().

parse_email(Email) ->
    case string:split(Email, "@") of
        [Local, Domain] ->
            LocalPart = parse_local(Local),
            LocalPart ++ "@" ++ Domain;
        _ -> Email
    end.

parse_local(Local) ->
    case string:split(Local, "+") of
        [BeforePlus | _] ->
            BeforePlusParts = string:split(BeforePlus, "."),
            lists:foldl(fun Part, Acc -> Acc ++ Part end, "", BeforePlusParts);
        _ -> Local
    end.