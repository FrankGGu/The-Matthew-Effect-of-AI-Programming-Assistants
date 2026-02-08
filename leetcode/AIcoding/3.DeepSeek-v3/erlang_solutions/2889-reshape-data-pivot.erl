-spec pivot(Data :: [[term()]], Col :: atom(), Val :: atom(), Agg :: atom()) -> [[term()]].
pivot(Data, Col, Val, Agg) ->
    Headers = hd(Data),
    ColIndex = index_of(Col, Headers),
    ValIndex = index_of(Val, Headers),
    AggIndex = index_of(Agg, Headers),

    Grouped = lists:foldl(fun(Row, Acc) ->
        ColVal = lists:nth(ColIndex, Row),
        ValVal = lists:nth(ValIndex, Row),
        AggVal = lists:nth(AggIndex, Row),
        case maps:find(ColVal, Acc) of
            {ok, Vals} -> 
                case maps:find(ValVal, Vals) of
                    {ok, _} -> Acc;
                    error -> maps:put(ColVal, maps:put(ValVal, AggVal, Vals), Acc)
                end;
            error -> maps:put(ColVal, maps:from_list([{ValVal, AggVal}]), Acc)
        end
    end, maps:new(), tl(Data)),

    ValHeaders = lists:usort(lists:flatmap(fun({_, Vals}) -> maps:keys(Vals) end, maps:to_list(Grouped))),
    NewHeaders = [Col | ValHeaders],

    Result = lists:map(fun({ColVal, Vals}) ->
        lists:foldl(fun(ValHeader, Row) ->
            case maps:find(ValHeader, Vals) of
                {ok, AggVal} -> Row ++ [AggVal];
                error -> Row ++ [null]
            end
        end, [ColVal], ValHeaders)
    end, maps:to_list(Grouped)),

    [NewHeaders | Result].

index_of(Item, List) ->
    index_of(Item, List, 1).

index_of(_, [], _) -> error;
index_of(Item, [Item | _], Index) -> Index;
index_of(Item, [_ | Rest], Index) -> index_of(Item, Rest, Index + 1).