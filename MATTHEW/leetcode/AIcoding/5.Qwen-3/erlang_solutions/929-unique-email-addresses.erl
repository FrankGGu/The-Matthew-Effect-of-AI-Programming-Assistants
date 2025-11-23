-module(unique_email_addresses).
-export([num_uniqueEmails/1]).

num_uniqueEmails(Emails) ->
    lists:foldl(fun(Email, Acc) ->
        Processed = process_email(Email),
        sets:add_element(Processed, Acc)
    end, sets:new(), Emails),
    sets:size(Acc).

process_email(Email) ->
    [LocalPart, Domain] = string:split(Email, "@"),
    Local = process_local(LocalPart),
    Local ++ "@" ++ Domain.

process_local(Local) ->
    case string:split(Local, "+") of
        [Part1, _] -> process_dots(Part1);
        _ -> process_dots(Local)
    end.

process_dots(S) ->
    string:replace(S, ".", "", all).