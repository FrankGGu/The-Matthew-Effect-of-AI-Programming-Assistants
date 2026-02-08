-module(partition).
-export([partition/1]).

partition(S) ->
  String = string:to_list(S),
  partition_helper(String, []).

partition_helper([], Acc) ->
  [lists:reverse(Acc)];
partition_helper(String, Acc) ->
  Result = lists:foldl(
             fun(Len, Acc2) ->
               case Len > length(String) of
                 true ->
                   Acc2;
                 false ->
                   Sub = lists:sublist(String, Len),
                   case is_palindrome(Sub) of
                     true ->
                       Acc2 ++ partition_helper(lists:nthtail(Len, String), [Sub | Acc]);
                     false ->
                       Acc2
                   end
               end
             end,
             [],
             lists:seq(1, length(String))),
  Result.

is_palindrome(String) ->
  String =:= lists:reverse(String).