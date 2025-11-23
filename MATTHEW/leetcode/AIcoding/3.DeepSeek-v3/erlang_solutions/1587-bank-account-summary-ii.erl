-spec account_summary(Users :: [[unicode:unicode_binary()]], Transactions :: [[unicode:unicode_binary()]]) -> [[unicode:unicode_binary()]].
account_summary(Users, Transactions) ->
    UserMap = lists:foldl(fun([Id, Name, _], Acc) ->
                            maps:put(Id, Name, Acc)
                          end, #{}, Users),

    TransMap = lists:foldl(fun([_, From, To, Amount], Acc) ->
                            case maps:get(To, Acc, undefined) of
                                undefined -> maps:put(To, binary_to_integer(Amount), Acc);
                                Balance -> maps:put(To, Balance + binary_to_integer(Amount), Acc)
                            end
                          end, #{}, Transactions),

    Result = maps:fold(fun(Id, Balance, Acc) ->
                          case Balance >= 10000 of
                              true -> 
                                  Name = maps:get(Id, UserMap),
                                  [[Id, Name, integer_to_binary(Balance)] | Acc];
                              false -> Acc
                          end
                       end, [], TransMap),

    lists:sort(Result).