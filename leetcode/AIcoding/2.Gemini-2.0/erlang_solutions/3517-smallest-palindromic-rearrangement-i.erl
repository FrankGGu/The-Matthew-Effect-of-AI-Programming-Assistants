-module(smallest_palindrome_rearrangement).
-export([smallest_palindrome/1]).

smallest_palindrome(S) ->
  Counts = lists:foldl(fun(C, Acc) ->
                            case maps:is_key(C, Acc) of
                              true -> maps:update(C, maps:get(C, Acc) + 1, Acc);
                              false -> maps:put(C, 1, Acc)
                            end
                        end, #{}, S),

  OddChars = maps:fold(fun(K, V, Acc) ->
                           if V rem 2 == 1 then
                             [K | Acc]
                           else
                             Acc
                           end
                        end, [], Counts),

  case length(OddChars) > 1 of
    true -> "";
    false ->
      {Left, Mid, Right} = lists:foldl(fun(K, {L, M, R}) ->
                                          V = maps:get(K, Counts),
                                          Half = V div 2,
                                          LeftPart = lists:duplicate(Half, K),

                                          if V rem 2 == 1 then
                                            {L ++ LeftPart, [K], R ++ LeftPart}
                                          else
                                            {L ++ LeftPart, M, R ++ LeftPart}
                                          end
                                        end, {[], [], []}, lists:sort(maps:keys(Counts))),
      lists:flatten([Left, Mid, lists:reverse(Right)])
  end.