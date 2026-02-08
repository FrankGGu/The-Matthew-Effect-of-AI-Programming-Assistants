-spec num_friend_requests(Ages :: [integer()]) -> integer().
num_friend_requests(Ages) ->
    Counts = lists:foldl(fun(Age, Acc) ->
                            maps:update_with(Age, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, Ages),
    Keys = lists:sort(maps:keys(Counts)),
    Res = lists:foldl(fun(A, Acc1) ->
                        lists:foldl(fun(B, Acc2) ->
                                      case B =< 0.5 * A + 7 orelse B > A orelse (B > 100 andalso A < 100) of
                                          true -> Acc2;
                                          false -> 
                                              CA = maps:get(A, Counts),
                                              CB = maps:get(B, Counts),
                                              if 
                                                  A == B -> Acc2 + CA * (CA - 1);
                                                  true -> Acc2 + CA * CB
                                              end
                                      end
                                   end, Acc1, Keys)
                      end, 0, Keys),
    Res.