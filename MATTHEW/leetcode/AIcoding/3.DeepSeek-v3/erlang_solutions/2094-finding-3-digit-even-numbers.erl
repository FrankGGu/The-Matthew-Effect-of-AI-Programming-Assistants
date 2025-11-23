-spec find_even_numbers(Digits :: [integer()]) -> [integer()].
find_even_numbers(Digits) ->
    Perms = lists:foldl(fun(X, Acc) ->
                            lists:foldl(fun(Y, Acc1) ->
                                            lists:foldl(fun(Z, Acc2) ->
                                                            case (X /= Y) and (Y /= Z) and (X /= Z) of
                                                                true -> [100*X + 10*Y + Z | Acc2];
                                                                false -> Acc2
                                                            end
                                                        end, Acc1, Digits)
                                        end, Acc, Digits)
                        end, [], Digits),
    Filtered = lists:filter(fun(N) -> N >= 100 andalso (N rem 2) == 0 end, Perms),
    Sorted = lists:usort(Filtered),
    Sorted.