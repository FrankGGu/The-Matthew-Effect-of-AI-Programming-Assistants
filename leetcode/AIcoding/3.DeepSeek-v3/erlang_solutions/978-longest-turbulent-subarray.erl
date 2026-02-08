-spec max_turbulence_size(Arr :: [integer()]) -> integer().
max_turbulence_size(Arr) ->
    case Arr of
        [] -> 0;
        [_] -> 1;
        _ ->
            {Max, _, _} = lists:foldl(fun(X, {Max, PrevLen1, PrevLen2}) ->
                case {PrevLen1, PrevLen2} of
                    {undefined, undefined} -> {Max, 1, 1};
                    {PL1, undefined} ->
                        if
                            X > hd(Arr) -> {max(Max, 2), 2, 1};
                            X < hd(Arr) -> {max(Max, 2), 1, 2};
                            true -> {Max, 1, 1}
                        end;
                    {PL1, PL2} ->
                        case {X > lists:nth(PL1, Arr), X < lists:nth(PL2, Arr)} of
                            {true, _} -> {max(Max, PL2 + 1), PL2 + 1, 1};
                            {_, true} -> {max(Max, PL1 + 1), 1, PL1 + 1};
                            _ -> {Max, 1, 1}
                        end
                end
            end, {1, undefined, undefined}, tl(Arr)),
            Max
    end.