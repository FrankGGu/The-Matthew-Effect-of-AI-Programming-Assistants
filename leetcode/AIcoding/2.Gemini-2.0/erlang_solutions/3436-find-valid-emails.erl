-module(valid_emails).
-export([find_valid_emails/1]).

find_valid_emails(Emails) ->
  [Email || Email <- Emails, is_valid_email(Email)].

is_valid_email(Email) ->
  case re:run(Email, "^[a-zA-Z][a-zA-Z0-9_.-]*@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$", [{capture, all, binary}]) of
    {match, _} -> true;
    nomatch -> false
  end.