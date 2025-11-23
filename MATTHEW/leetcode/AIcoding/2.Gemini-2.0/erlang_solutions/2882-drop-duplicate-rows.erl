-module(solution).
-export([delete_duplicate_emails/1]).

delete_duplicate_emails(DataFrame) ->
  Emails = lists:map(fun(Row) -> proplists:get_value("Email", Row) end, DataFrame),
  UniqueEmails = lists:usort(Emails),
  EmailCounts = lists:foldl(fun(Email, Acc) ->
                                   case lists:keyfind(Email, 1, Acc) of
                                     false ->
                                       [{Email, 1} | Acc];
                                     {Email, Count} ->
                                       lists:keyreplace(Email, 1, Acc, {Email, Count + 1})
                                   end
                               end, [], Emails),
  DuplicateEmails = [Email || {Email, Count} <- EmailCounts, Count > 1],
  lists:filter(fun(Row) ->
                   Email = proplists:get_value("Email", Row),
                   not lists:member(Email, DuplicateEmails)
               end, DataFrame).