-spec is_scramble(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> boolean().
is_scramble(S1, S2) ->
    is_scramble(S1, S2, #{}).

-spec is_scramble(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary(), Memo :: map()) -> boolean().
is_scramble(S1, S2, Memo) when S1 =:= S2 -> true;
is_scramble(S1, S2, Memo) ->
    case maps:get({S1, S2}, Memo, undefined) of
        undefined ->
            case length(S1) of
                1 -> false;
                _ ->
                    N = length(S1),
                    lists:foldl(fun(Index, Acc) ->
                        case Acc of
                            true -> true;
                            false ->
                                {X1, X2} = split_at(S1, Index),
                                {Y1, Y2} = split_at(S2, Index),
                                (is_scramble(X1, Y1, Memo) andalso is_scramble(X2, Y2, Memo)) orelse
                                (is_scramble(X1, Y2, Memo) andalso is_scramble(X2, Y1, Memo))
                        end
                    end, false, lists:seq(1, N-1));
            end;
        Result -> Result
    end.

split_at(List, N) ->
    lists:split(N, List).
