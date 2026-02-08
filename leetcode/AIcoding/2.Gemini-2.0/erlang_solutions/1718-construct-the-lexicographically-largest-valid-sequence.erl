-module(largest_sequence).
-export([construct_distanced_sequence/1]).

construct_distanced_sequence(N) ->
    construct_distanced_sequence_helper(N, [], lists:seq(N, 1, -1)).

construct_distanced_sequence_helper(N, Acc, Remaining) ->
    case length(Acc) of
        2 * N - 1 ->
            lists:reverse(Acc);
        Len ->
            find_next_number(N, Len, Acc, Remaining)
    end.

find_next_number(N, Len, Acc, Remaining) ->
    lists:foldl(
        fun(Num, {Found, Result, RemainingNumbers}) ->
            case Found of
                true ->
                    {Found, Result, RemainingNumbers};
                false ->
                    case can_place(Num, Len, Acc) of
                        true ->
                            case Num =:= 1 of
                                true ->
                                    {true, [Num | Acc], lists:delete(Num, RemainingNumbers)};
                                false ->
                                    case lists:member(Num, RemainingNumbers) of
                                        true ->
                                            {true, [Num | insert_zeros(Num - 1, Acc)], lists:delete(Num, RemainingNumbers)}
                                        false ->
                                            {false, Result, RemainingNumbers}
                                    end
                            end;
                        false ->
                            {false, Result, RemainingNumbers}
                    end
            end
        end,
        {false, [], Remaining},
        Remaining
    ) of
    {true, Result, _} ->
        construct_distanced_sequence_helper(N, Result, _);
    {false, _, _} ->
        []
    end.

can_place(Num, Len, Acc) ->
    case Num =:= 1 of
        true ->
            true;
        false ->
            Index = Len + Num,
            case Index > length(Acc) of
                true ->
                    true;
                false ->
                    lists:nth(Index, lists:reverse(Acc)) =:= 0
            end
    end.

insert_zeros(Num, Acc) ->
    insert_zeros_helper(Num, Acc, []).

insert_zeros_helper(0, Acc, Result) ->
  [0|lists:reverse(Result)++Acc];
insert_zeros_helper(N, Acc, Result) ->
  insert_zeros_helper(N-1, Acc, [0|Result]).