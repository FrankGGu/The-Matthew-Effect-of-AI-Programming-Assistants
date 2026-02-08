-module(palindrome_partitioning).
-export([partition/1]).

-spec partition(String :: string()) -> [[string()]].
partition(String) ->
  S = string:to_list(String),
  partition_helper(S).

partition_helper(S) ->
  case S of
    [] -> [[]];
    _ ->
      lists:flatten([
        begin
          Prefix = lists:sublist(S, I),
          if is_palindrome(Prefix) then
            lists:map(
              fun(SuffixPartitions) -> [string:from_list(Prefix) | SuffixPartitions] end,
              partition_helper(lists:nthtail(I, S))
            )
          else
            []
          end
        end
        || I <- lists:seq(1, length(S))
      ], true)
  end.

is_palindrome(L) ->
  L =:= lists:reverse(L).