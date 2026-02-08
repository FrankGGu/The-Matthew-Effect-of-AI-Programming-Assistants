-module(solution).
-export([constructDistancedSequence/1]).

constructDistancedSequence(N) ->
    Size = 2 * N - 1,
    Sequence = lists:duplicate(Size, 0),
    Used = sets:from_list(lists:seq(1, N)),
    {ok, Result} = backtrack(1, Sequence, Used, N),
    Result.

backtrack(Index, Sequence, Used, N) ->
    case Index > length(Sequence) of
        true -> {ok, Sequence};
        false ->
            case lists:nth(Index, Sequence) of
                0 ->
                    lists:foldl(fun(Number, Acc) ->
                        case Acc of
                            {ok, _} -> Acc;
                            {error, _} ->
                                case sets:is_element(Number, Used) of
                                    true ->
                                        NewSequence = set_element(Index, Number, Sequence),
                                        NewUsed = sets:del_element(Number, Used),
                                        if
                                            Number == 1 ->
                                                case backtrack(Index + 1, NewSequence, NewUsed, N) of
                                                    {ok, Seq} -> {ok, Seq};
                                                    {error, _} -> {error, not_found}
                                                end;
                                            true ->
                                                case Index + Number =< length(Sequence) of
                                                    true ->
                                                        case lists:nth(Index + Number, NewSequence) of
                                                            0 ->
                                                                NewSequence2 = set_element(Index + Number, Number, NewSequence),
                                                                case backtrack(Index + 1, NewSequence2, NewUsed, N) of
                                                                    {ok, Seq} -> {ok, Seq};
                                                                    {error, _} -> {error, not_found}
                                                                end;
                                                            _ -> {error, not_found}
                                                        end;
                                                    false -> {error, not_found}
                                                end
                                        end;
                                    false -> {error, not_found}
                                end
                        end
                    end, {error, not_found}, lists:reverse(lists:seq(1, N)));
                _ ->
                    backtrack(Index + 1, Sequence, Used, N)
            end
    end.

set_element(Index, Value, List) ->
    {Left, [_ | Right]} = lists:split(Index - 1, List),
    Left ++ [Value | Right].