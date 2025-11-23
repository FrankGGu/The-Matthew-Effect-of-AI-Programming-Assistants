-module(interleaving_string).
-export([is_interleave/3]).

is_interleave(S1, S2, S3) ->
  Len1 = length(S1),
  Len2 = length(S2),
  Len3 = length(S3),
  if Len1 + Len2 /= Len3 ->
    false
  else
    DP = array:new(Len1 + 1, array:new(Len2 + 1, false)),
    DP = array:set({0,0}, true, DP),

    lists:foldl(
      fun(I, AccDP) ->
        DP1 = lists:foldl(
          fun(J, AccDP1) ->
            Value = array:get({I,J}, AccDP),
            if Value == true ->
              if I < Len1 andalso lists:nth(I+1, S1) == lists:nth(I+J+1, S3) ->
                AccDP1 = array:set({I+1,J}, true, AccDP1)
              else
                AccDP1
              end,
              if J < Len2 andalso lists:nth(J+1, S2) == lists:nth(I+J+1, S3) ->
                AccDP1 = array:set({I,J+1}, true, AccDP1)
              else
                AccDP1
              end;
              AccDP1
            end
          , AccDP, lists:seq(0,Len2))
      , DP, lists:seq(0, Len1)),
    array:get({Len1,Len2}, DP)
  end.