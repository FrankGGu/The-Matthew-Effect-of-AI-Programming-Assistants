-module(longest_common_subsequence).
-export([longest_common_subsequence/2]).

longest_common_subsequence(Text1, Text2) ->
  Len1 = length(Text1),
  Len2 = length(Text2),
  DP = array:new([Len1 + 1, Len2 + 1], {fixed, 0}),

  lists:foreach(
    fun(I) ->
      lists:foreach(
        fun(J) ->
          case lists:nth(I, Text1) == lists:nth(J, Text2) of
            true ->
              array:set({I, J}, array:get({I - 1, J - 1}, DP) + 1, DP);
            false ->
              array:set({I, J}, max(array:get({I - 1, J}, DP), array:get({I, J - 1}, DP)), DP)
          end
        end,
        lists:seq(1, Len2)
      )
    end,
    lists:seq(1, Len1)
  ),
  array:get({Len1, Len2}, DP).