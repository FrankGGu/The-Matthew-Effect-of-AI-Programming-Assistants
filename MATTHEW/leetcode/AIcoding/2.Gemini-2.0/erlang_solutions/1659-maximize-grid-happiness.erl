-module(maximize_happiness).
-export([maximize_happiness/3]).

maximize_happiness(M, N, IntrovertsCount, ExtrovertsCount) ->
    memo(M, N, IntrovertsCount, ExtrovertsCount, 0, 0, dict:new()).

memo(M, N, IntrovertsCount, ExtrovertsCount, Row, Col, Memo) ->
    Key = {Row, Col, IntrovertsCount, ExtrovertsCount, dict:to_list(Memo)}.
    case dict:find(Key, Memo) of
        {ok, Value} ->
            Value;
        error ->
            case Row == M of
                true ->
                    0;
                false ->
                    NextRow = case Col == N - 1 of
                                  true -> Row + 1;
                                  false -> Row
                              end,
                    NextCol = case Col == N - 1 of
                                  true -> 0;
                                  false -> Col + 1
                              end,

                    Skip = memo(M, N, IntrovertsCount, ExtrovertsCount, NextRow, NextCol, Memo),

                    Introvert = case IntrovertsCount > 0 of
                                    true ->
                                        Happiness = 30,
                                        Happiness1 = case Col > 0 of
                                                         true -> Happiness - 30;
                                                         false -> Happiness
                                                     end,
                                        Happiness2 = case Row > 0 of
                                                         true -> Happiness1 - 30;
                                                         false -> Happiness1
                                                     end,
                                        NewMemo1 = dict:store({Row,Col},1, Memo),
                                        Value = Happiness2 + memo(M, N, IntrovertsCount - 1, ExtrovertsCount, NextRow, NextCol, NewMemo1),
                                        Value;
                                    false ->
                                        -1000000
                                end,
                    Extrovert = case ExtrovertsCount > 0 of
                                    true ->
                                        Happiness = 20,
                                        Happiness1 = case Col > 0 of
                                                         true ->
                                                             case dict:fetch({Row, Col-1},Memo) of
                                                                 1 -> Happiness -30;
                                                                 2 -> Happiness +20
                                                             end;
                                                         false -> Happiness
                                                     end,
                                        Happiness2 = case Row > 0 of
                                                         true ->
                                                             case dict:fetch({Row-1, Col},Memo) of
                                                                 1 -> Happiness1 -30;
                                                                 2 -> Happiness1 +20
                                                             end;
                                                         false -> Happiness1
                                                     end,
                                        NewMemo2 = dict:store({Row,Col},2, Memo),
                                        Value = Happiness2 + memo(M, N, IntrovertsCount, ExtrovertsCount - 1, NextRow, NextCol, NewMemo2),
                                        Value;
                                    false ->
                                        -1000000
                                end,

                    MaxHappiness = lists:max([Skip, Introvert, Extrovert]),
                    NewMemo = dict:store(Key, MaxHappiness, Memo),
                    MaxHappiness
            end
    end.