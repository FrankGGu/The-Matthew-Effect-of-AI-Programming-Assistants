-module(masking_personal_information).
-export([mask_pii/1]).

mask_pii(S) ->
  case string:chr(S, '@') of
    nomatch ->
      mask_phone_number(S);
    _ ->
      mask_email(S)
  end.

mask_email(S) ->
  [Name, Domain] = string:split(S, "@", all),
  [Prefix, Suffix] = string:split(lists:last(string:split(Domain, ".", all)), ".", all),
  lists:concat([lists:sublist(Name, 1, 1), "*****", lists:last(Name), "@", Prefix, ".", Suffix]).

mask_phone_number(S) ->
  Digits = lists:filter(fun(C) -> C >= $0 andalso C <= $9 end, string:to_list(S)),
  Length = length(Digits),
  Last10 = lists:sublist(Digits, Length - 9, 10),
  Local = lists:concat(lists:[lists:nth(X, Last10) || X <- [8,9,10]]),
  Middle = lists:concat(lists:[lists:nth(X, Last10) || X <- [5,6,7]]),
  First = lists:concat(lists:[lists:nth(X, Last10) || X <- [2,3,4]]),
  Leading = case Length of
    10 -> "";
    11 -> "+*-***-***-";
    12 -> "++*-***-***-";
    13 -> "+++*-***-***-";
    _ -> ""
  end,
  lists:concat([Leading, "***-***-", First, "-", Middle, "-", Local]).