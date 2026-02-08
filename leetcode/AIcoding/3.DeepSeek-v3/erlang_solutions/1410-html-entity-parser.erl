-module(solution).
-export([entity_parser/1]).

entity_parser(Text) ->
    Entities = [
        {"&quot;", "\""},
        {"&apos;", "'"},
        {"&amp;", "&"},
        {"&gt;", ">"},
        {"&lt;", "<"},
        {"&frasl;", "/"}
    ],
    parse(Text, Entities, [], []).

parse([], _, Acc, _) ->
    lists:reverse(Acc);
parse([$& | Rest], Entities, Acc, Buffer) ->
    case match_entity(Rest, Entities, [$& | Buffer]) of
        {ok, Entity, Replacement, NewRest} ->
            parse(NewRest, Entities, lists:reverse(Replacement) ++ Acc, []);
        continue ->
            parse(Rest, Entities, Acc, [$& | Buffer])
    end;
parse([C | Rest], Entities, Acc, []) ->
    parse(Rest, Entities, [C | Acc], []);
parse([C | Rest], Entities, Acc, Buffer) ->
    parse(Rest, Entities, Acc, [C | Buffer]).

match_entity(Text, Entities, Buffer) ->
    match_entity(Text, Entities, Buffer, Buffer).

match_entity(_, [], _, _) ->
    continue;
match_entity(Text, [{Entity, Replacement} | Rest], Buffer, OriginalBuffer) ->
    case lists:prefix(Entity, OriginalBuffer ++ Text) of
        true ->
            EntityLength = length(Entity),
            case length(OriginalBuffer ++ Text) >= EntityLength of
                true ->
                    {ok, Entity, Replacement, lists:nthtail(EntityLength - length(OriginalBuffer), Text)};
                false ->
                    match_entity(Text, Rest, Buffer, OriginalBuffer)
            end;
        false ->
            match_entity(Text, Rest, Buffer, OriginalBuffer)
    end.