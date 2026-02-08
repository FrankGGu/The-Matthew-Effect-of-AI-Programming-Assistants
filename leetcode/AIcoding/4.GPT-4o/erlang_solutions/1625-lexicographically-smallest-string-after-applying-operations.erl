-module(lex_smallest_string).
-export([find_lex_smallest_string/2]).

find_lex_smallest_string(S, A) ->
    S1 = lists:foldl(fun({C, P}, Acc) -> 
                          case P of 
                              1 -> lists:map(fun(X) -> if X =:= C -> $\a; true -> X end end, Acc);
                              _ -> Acc
                          end 
                      end, S, A),
    lists:sort(lists:usort(S1).