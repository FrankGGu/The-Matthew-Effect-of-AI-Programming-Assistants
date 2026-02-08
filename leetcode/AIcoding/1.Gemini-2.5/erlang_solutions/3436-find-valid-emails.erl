-module(solution).
-export([find_valid_emails/1]).

find_valid_emails(Emails) ->
    lists:filter(fun is_valid_email/1, Emails).

is_valid_email(Email) ->
    Regex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    case re:run(Email, Regex, [{capture, none}]) of
        {match, _} -> true;
        nomatch -> false
    end.