-spec is_valid(S :: unicode:unicode_binary()) -> boolean().
is_valid(S) ->
    is_valid(S, []).

is_valid(<<>>, Stack) ->
    Stack == [];
is_valid(<<"a", Rest/binary>>, Stack) ->
    is_valid(Rest, [a | Stack]);
is_valid(<<"b", Rest/binary>>, [a | Stack]) ->
    is_valid(Rest, [b, a | Stack]);
is_valid(<<"c", Rest/binary>>, [b, a | Stack]) ->
    is_valid(Rest, Stack);
is_valid(_, _) ->
    false.