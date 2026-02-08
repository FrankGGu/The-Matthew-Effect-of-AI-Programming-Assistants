-module(interleaving_string).
-export([is_interleave/3]).

is_interleave(S1, S2, S3) ->
  Len1 = length(S1),
  Len2 = length(S2),
  Len3 = length(S3),

  if Len1 + Len2 /= Len3 ->
    false
  else
    DP = array:new([Len1+1, Len2+1], {default, false}),
    array:set({0,0}, DP, true),
    is_interleave_helper(S1, S2, S3, 0, 0, DP, Len1, Len2)
  end.

is_interleave_helper(S1, S2, S3, I, J, DP, Len1, Len2) ->
  case array:get({I, J}, DP) of
    true -> true;
    false ->
      case {I < Len1, J < Len2} of
        {true, true} ->
          Char1 = lists:nth(I+1, S1),
          Char2 = lists:nth(J+1, S2),
          Char3 = lists:nth(I+J+1, S3),

          case {Char1 == Char3, Char2 == Char3} of
            {true, true} ->
              Res1 = is_interleave_helper(S1, S2, S3, I+1, J, DP, Len1, Len2),
              Res2 = is_interleave_helper(S1, S2, S3, I, J+1, DP, Len1, Len2),
              Res = Res1 orelse Res2,
              array:set({I, J}, DP, Res),
              Res;

            {true, false} ->
              Res = is_interleave_helper(S1, S2, S3, I+1, J, DP, Len1, Len2),
              array:set({I, J}, DP, Res),
              Res;

            {false, true} ->
              Res = is_interleave_helper(S1, S2, S3, I, J+1, DP, Len1, Len2),
              array:set({I, J}, DP, Res),
              Res;
            {false, false} ->
              array:set({I, J}, DP, false),
              false
          end;
        {true, false} ->
           Char1 = lists:nth(I+1, S1),
           Char3 = lists:nth(I+J+1, S3),
           if Char1 == Char3 ->
             Res = is_interleave_helper(S1, S2, S3, I+1, J, DP, Len1, Len2),
             array:set({I, J}, DP, Res),
             Res
           else
             array:set({I, J}, DP, false),
             false
           end;
        {false, true} ->
           Char2 = lists:nth(J+1, S2),
           Char3 = lists:nth(I+J+1, S3),
           if Char2 == Char3 ->
             Res = is_interleave_helper(S1, S2, S3, I, J+1, DP, Len1, Len2),
             array:set({I, J}, DP, Res),
             Res
           else
             array:set({I, J}, DP, false),
             false
           end;
        {false, false} ->
          true
      end
  end.