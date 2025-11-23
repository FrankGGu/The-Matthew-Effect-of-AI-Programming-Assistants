-spec min_operations(Nums :: [integer()], X :: integer()) -> integer().
min_operations(Nums, X) ->
    Total = lists:sum(Nums),
    Target = Total - X,
    case Target of
        0 -> length(Nums);
        _ ->
            case Target < 0 of
                true -> -1;
                false ->
                    {MaxLen, Sum, Left} = lists:foldl(fun(N, {MaxLen, Sum, Left}) ->
                        NewSum = Sum + N,
                        case NewSum > Target of
                            true ->
                                {MaxLen, NewSum, adjust_left(Left, NewSum, Target, Nums)};
                            false ->
                                case NewSum =:= Target of
                                    true -> {max(MaxLen, Left + 1), NewSum, Left + 1};
                                    false -> {MaxLen, NewSum, Left + 1}
                                end
                        end
                    end, {-1, 0, 0}, Nums),
                    case MaxLen of
                        -1 -> -1;
                        _ -> length(Nums) - MaxLen
                    end
            end
    end.

adjust_left(Left, Sum, Target, Nums) ->
    case Sum > Target of
        true ->
            adjust_left(Left + 1, Sum - lists:nth(Left + 1, Nums), Target, Nums);
        false -> Left
    end.