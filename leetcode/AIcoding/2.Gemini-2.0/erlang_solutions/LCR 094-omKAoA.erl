-module(partitioning_ii).
-export([minCut/1]).

minCut(S) ->
  N = length(S),
  IsPalindrome = create_is_palindrome(S, N),
  DP = lists:duplicate(N + 1, 0),
  DP ! N,
  lists:foreach(fun(I) ->
                    lists:foreach(fun(J) ->
                                      if IsPalindrome ! {I, J} ->
                                        NextCut = DP ! (J + 1) + 1,
                                        CurCut = DP ! I;
                                        true ->
                                          CurCut = DP ! I,
                                          NextCut = CurCut
                                      end,
                                      DP ! I, min(CurCut, NextCut)
                                  end, lists:seq(I, N - 1))
                end, lists:seq(N - 1, 0, -1)),
  DP ! 0 - 1.

create_is_palindrome(S, N) ->
  IsPalindrome = dict:new(),
  lists:foreach(fun(I) ->
                    IsPalindrome ! {I, I}, true
                end, lists:seq(0, N - 1)),
  lists:foreach(fun(I) ->
                    if I + 1 < N andalso lists:nth(I + 1, string:characters(S)) == lists:nth(I + 2, string:characters(S)) ->
                      IsPalindrome ! {I, I + 1}, true;
                      true ->
                        ok
                    end
                end, lists:seq(0, N - 2)),
  lists:foreach(fun(Len) ->
                    lists:foreach(fun(I) ->
                                      J = I + Len,
                                      if J < N ->
                                        if IsPalindrome ! {I + 1, J - 1} andalso lists:nth(I + 1, string:characters(S)) == lists:nth(J + 1, string:characters(S)) ->
                                          IsPalindrome ! {I, J}, true;
                                          true ->
                                            ok
                                        end;
                                        true ->
                                          ok
                                      end
                                  end, lists:seq(0, N - 1))
                end, lists:seq(2, N - 1)),
  IsPalindrome.