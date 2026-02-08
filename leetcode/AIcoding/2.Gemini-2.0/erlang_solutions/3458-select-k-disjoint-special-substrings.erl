-module(solution).
-export([max_score/3]).

max_score(S, K, Special) ->
  N = length(S),
  Special_len = length(Special),
  DP = array:new([N + 1, K + 1], {0, 0}),

  lists:foldl(
    fun(I, _) ->
      array:set(I, DP, array:get(I - 1, DP));

      case string:substr(S, I, Special_len) of
        Special ->
          lists:foreach(
            fun(J) ->
              array:set(
                {I + Special_len - 1, J},
                DP,
                max(
                  array:get({I + Special_len - 1, J}, DP),
                  {element(1, array:get({I - 1, J - 1}, DP)) + Special_len, 1}
                )
              );
              array:set(
                {I + Special_len - 1, J},
                DP,
                max(
                  array:get({I + Special_len - 1, J}, DP),
                  array:get({I + Special_len - 2, J}, DP)
                )
              )
            end,
            lists:seq(1, K)
          );

          array:set(
            {I + Special_len - 1, 0},
            DP,
            array:get(I - 1, DP)
          );

        _ ->
          ok
      end
    end,
    lists:seq(1, N - Special_len + 1),
    ok
  ),

  element(1, array:get({N, K}, DP)).

max({Score1, Count1}, {Score2, Count2}) ->
  if
    Score1 > Score2 -> {Score1, Count1};
    Score1 < Score2 -> {Score2, Count2};
    true -> {Score1, Count1 + Count2}
  end.