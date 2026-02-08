-module(solution).
-export([check_if_string_contains_all_codes/2]).

check_if_string_contains_all_codes(S, K) ->
  Len = length(S),
  if Len < K then
    false
  else
    Needed = 1 bsl K,
    Seen = sets:new(),
    lists:foldl(fun(I, Acc) ->
                  if I + K > Len then
                    Acc
                  else
                    Sub = binary_to_integer(list_to_binary(lists:sublist(string:characters(S), I, K))),
                    if not sets:is_element(Sub, Acc) then
                      sets:add_element(Sub, Acc)
                    else
                      Acc
                    end
                  end
                end, sets:new(), lists:seq(1, Len - K + 1)),
    sets:size(Seen) =:= Needed
  end.