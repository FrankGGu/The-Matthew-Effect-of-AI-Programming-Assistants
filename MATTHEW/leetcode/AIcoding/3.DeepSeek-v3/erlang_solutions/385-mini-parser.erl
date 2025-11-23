-record(nested_integer, {integer, list}).

-spec deserialize(S :: unicode:unicode_binary()) -> #nested_integer{}.
deserialize(S) ->
    {N, _} = parse(S),
    N.

parse(<<$[, Rest/binary>>) ->
    {List, Rest1} = parse_list(Rest, []),
    {#nested_integer{list=List}, Rest1};
parse(S) ->
    {Int, Rest} = parse_int(S, <<>>),
    {#nested_integer{integer=list_to_integer(binary_to_list(Int))}, Rest}.

parse_list(<<$], Rest/binary>>, Acc) ->
    {lists:reverse(Acc), Rest};
parse_list(<<$,, Rest/binary>>, Acc) ->
    parse_list(Rest, Acc);
parse_list(S, Acc) ->
    {N, Rest} = parse(S),
    parse_list(Rest, [N | Acc]).

parse_int(<<C, Rest/binary>>, Acc) when C >= $0, C =< $9 ->
    parse_int(Rest, <<Acc/binary, C>>);
parse_int(<<$-, Rest/binary>>, <<>>) ->
    parse_int(Rest, <<$->>);
parse_int(S, Acc) ->
    {Acc, S}.