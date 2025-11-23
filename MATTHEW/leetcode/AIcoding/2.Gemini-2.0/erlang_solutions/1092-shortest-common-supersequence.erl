-module(shortestCommonSupersequence).
-export([shortestCommonSupersequence/2]).

shortestCommonSupersequence(Str1, Str2) ->
  LCS = longestCommonSubsequence(Str1, Str2),
  SCS = buildSCS(Str1, Str2, LCS),
  SCS.

longestCommonSubsequence(Str1, Str2) ->
  longestCommonSubsequence(string:to_list(Str1), string:to_list(Str2)).

longestCommonSubsequence(L1, L2) ->
  N = length(L1),
  M = length(L2),
  DP = array:new([N+1, M+1], {default, 0}),

  % Fill the DP table
  lists:foreach(fun(I) ->
                    lists:foreach(fun(J) ->
                                      case L1 =:= [] orelse L2 =:= [] of
                                        true ->
                                          array:set({I, J}, 0, DP);
                                        false ->
                                          case lists:nth(I, L1) =:= lists:nth(J, L2) of
                                            true ->
                                              Val = array:get({I-1, J-1}, DP) + 1,
                                              array:set({I, J}, Val, DP);
                                            false ->
                                              Val1 = array:get({I-1, J}, DP),
                                              Val2 = array:get({I, J-1}, DP),
                                              Max = max(Val1, Val2),
                                              array:set({I, J}, Max, DP)
                                          end
                                      end
                                  end, lists:seq(1, M))
                end, lists:seq(1, N)),

  % Backtrack to find the LCS
  LCS = backtrackLCS(L1, L2, N, M, DP, []),
  lists:reverse(LCS).

backtrackLCS(L1, L2, I, J, DP, LCS) ->
  case {I, J} of
    {0, _} -> LCS;
    {_, 0} -> LCS;
    _ ->
      case lists:nth(I, L1) =:= lists:nth(J, L2) of
        true ->
          backtrackLCS(L1, L2, I-1, J-1, DP, [lists:nth(I, L1) | LCS]);
        false ->
          case array:get({I-1, J}, DP) > array:get({I, J-1}, DP) of
            true ->
              backtrackLCS(L1, L2, I-1, J, DP, LCS);
            false ->
              backtrackLCS(L1, L2, I, J-1, DP, LCS)
          end
      end
  end.

buildSCS(Str1, Str2, LCS) ->
  buildSCS(string:to_list(Str1), string:to_list(Str2), LCS, []).

buildSCS(L1, L2, LCS, Acc) ->
  case {L1, L2, LCS} of
    {[], [], []} -> lists:reverse(Acc);
    {[], [], _} -> lists:reverse(Acc);
    {[], L2, []} -> lists:reverse(Acc) ++ L2;
    {L1, [], []} -> lists:reverse(Acc) ++ L1;
    {[], L2, [H|_]} -> lists:reverse(Acc) ++ L2;
    {L1, [], [H|_]} -> lists:reverse(Acc) ++ L1;
    {L1, L2, []} -> lists:reverse(Acc) ++ L1 ++ L2;
    {[H1|T1], [H2|T2], [LC|TLC]} ->
      case {H1 =:= LC, H2 =:= LC} of
        {true, true} -> buildSCS(T1, T2, TLC, [LC | Acc]);
        {true, false} -> buildSCS(T1, [H2|T2], [LC|TLC], [H2 | Acc]);
        {false, true} -> buildSCS([H1|T1], T2, [LC|TLC], [H1 | Acc]);
        {false, false} ->
          buildSCS(T1, [H2|T2], LCS, [H1 | Acc]) ++ buildSCS([H1|T1], T2, LCS, [] );
          case lists:prefix(string:to_list(Str1), string:to_list(Str2)) of
            true ->

                buildSCS([H1|T1], T2, LCS, [H1 | Acc]);
            false ->
                buildSCS(T1, [H2|T2], LCS, [H2 | Acc])
          end
      end;
    {[H1|T1], [H2|T2], []} ->
      lists:reverse(Acc) ++ [H1|T1] ++ [H2|T2]
  end.