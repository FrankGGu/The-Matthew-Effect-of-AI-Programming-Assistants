-module(unique_email_addresses).
-export([numUniqueEmails/1]).

numUniqueEmails(Emails) ->
  UniqueEmails = lists:usort([normalizeEmail(Email) || Email <- Emails]),
  length(UniqueEmails).

normalizeEmail(Email) ->
  [Local, Domain] = string:split(Email, "@"),
  NormalizedLocal = normalizeLocal(Local),
  NormalizedLocal ++ "@" ++ Domain.

normalizeLocal(Local) ->
  LocalWithoutPlus = case string:chr(Local, '+') of
                       nomatch -> Local;
                       Index -> string:substr(Local, 1, Index - 1)
                     end,
  string:replace(LocalWithoutPlus, ".", "", all).