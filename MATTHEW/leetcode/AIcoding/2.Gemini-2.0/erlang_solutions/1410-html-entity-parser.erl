-module(html_entity_parser).
-export([decode_html_entities/1]).

decode_html_entities(Text) ->
    decode_string(Text, []).

decode_string([], Acc) ->
    lists:reverse(Acc);
decode_string([$& | Rest], Acc) ->
    decode_entity(Rest, Acc, []);
decode_string([Char | Rest], Acc) ->
    decode_string(Rest, [Char | Acc]).

decode_entity([], Acc, EntityAcc) ->
    decode_string([$& | lists:reverse(EntityAcc)], Acc);
decode_entity([; | Rest], Acc, EntityAcc) ->
    Entity = lists:reverse(EntityAcc),
    case Entity of
        "quot" ->
            decode_string(Rest, [$", Acc]);
        "apos" ->
            decode_string(Rest, [$', Acc]);
        "amp" ->
            decode_string(Rest, [$&, Acc]);
        "gt" ->
            decode_string(Rest, [$>, Acc]);
        "lt" ->
            decode_string(Rest, [$<, Acc]);
        "frasl" ->
            decode_string(Rest, [$/, Acc]);
        _ ->
            decode_string(Rest, [$& | Entity ++ [$;] | Acc])
    end;
decode_entity([Char | Rest], Acc, EntityAcc) ->
    decode_entity(Rest, Acc, [Char | EntityAcc]).