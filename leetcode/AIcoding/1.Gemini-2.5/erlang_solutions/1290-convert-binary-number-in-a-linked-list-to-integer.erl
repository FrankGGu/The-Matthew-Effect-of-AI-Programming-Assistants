-record(list_node, {val=0, next=null}).

-spec getDecimalValue(Head :: list_node() | null) -> integer().
getDecimalValue(Head) ->
    getDecimalValue(Head, 0).

getDecimalValue(null, Acc) ->
    Acc;
getDecimalValue(#list_node{val=Val, next=Next}, Acc) ->
    NewAcc = Acc * 2 + Val,
    getDecimalValue(Next, NewAcc).