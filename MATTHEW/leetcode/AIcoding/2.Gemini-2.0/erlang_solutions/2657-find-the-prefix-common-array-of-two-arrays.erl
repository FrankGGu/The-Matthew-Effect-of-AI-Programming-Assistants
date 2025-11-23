-module(find_prefix_common_array).
-export([find_the_prefix_common_array/2]).

find_the_prefix_common_array(A, B) ->
    find_the_prefix_common_array(A, B, [], []).

find_the_prefix_common_array([], [], Acc, Result) ->
    lists:reverse(Result);
find_the_prefix_common_array([H1|T1], [H2|T2], Acc, Result) ->
    NewAcc = [H1|Acc],
    Common = lists:foldl(fun(X, Count) ->
                                  case lists:member(X, NewAcc) andalso lists:member(X, [H2|T2]) of
                                      true -> Count + 1;
                                      false -> Count
                                  end
                              end, 0, NewAcc),
    find_the_prefix_common_array(T1, T2, NewAcc, [Common|Result]).