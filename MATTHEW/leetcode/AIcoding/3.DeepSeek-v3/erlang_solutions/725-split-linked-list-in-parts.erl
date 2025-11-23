-spec split_list_to_parts(Root :: #list_node{} | null, K :: integer()) -> [#list_node{} | null].
split_list_to_parts(Root, K) ->
    Length = length(Root),
    BaseSize = Length div K,
    Extra = Length rem K,
    split(Root, K, BaseSize, Extra, []).

length(null) -> 0;
length(#list_node{next = Next}) -> 1 + length(Next).

split(_, 0, _, _, Acc) -> lists:reverse(Acc);
split(null, K, _, _, Acc) ->
    split(null, K - 1, 0, 0, [null | Acc]);
split(Root, K, BaseSize, Extra, Acc) ->
    {Part, Rest} = take(Root, BaseSize + (if Extra > 0 -> 1; true -> 0 end)),
    split(Rest, K - 1, BaseSize, Extra - 1, [Part | Acc]).

take(Root, 0) -> {null, Root};
take(null, _) -> {null, null};
take(Root = #list_node{next = Next}, N) ->
    {Part, Rest} = take(Next, N - 1),
    {Root#list_node{next = null}, Rest}.