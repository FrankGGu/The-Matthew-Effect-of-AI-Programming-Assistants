-module(find_valid_emails).
-export([find_valid_emails/1]).

find_valid_emails(Emails) ->
    lists:filter(fun(Email) -> is_valid_email(Email) end, Emails).

is_valid_email(Email) ->
    case string:split(Email, "@") of
        [LocalPart, Domain] when length(LocalPart) > 0, length(Domain) > 0 ->
            is_valid_local(LocalPart) andalso is_valid_domain(Domain);
        _ ->
            false
    end.

is_valid_local(Local) ->
    ValidChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!#$%&'*+/=?^_`{|}~-",
    lists:all(fun(C) -> lists:member(C, ValidChars) end, Local).

is_valid_domain(Domain) ->
    case string:split(Domain, ".") of
        Parts when length(Parts) >= 2 ->
            lists:all(fun(Part) -> is_valid_subdomain(Part) end, Parts);
        _ ->
            false
    end.

is_valid_subdomain(Subdomain) ->
    ValidChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-",
    case Subdomain of
        [] -> false;
        [H | T] when H == $- -> false;
        [H | T] when H == $- orelse H == $_ -> false;
        _ ->
            lists:all(fun(C) -> lists:member(C, ValidChars) end, Subdomain)
    end.