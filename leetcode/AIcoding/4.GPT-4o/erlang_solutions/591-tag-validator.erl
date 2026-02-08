-module(solution).
-export([is_valid/1]).

is_valid(S) ->
    Tags = parse_tags(S, []),
    case Tags of
        {ok, ParsedTags} -> validate_tags(ParsedTags, []);
        _ -> false
    end.

parse_tags([], Stack) -> {ok, lists:reverse(Stack)};
parse_tags([H|T], Stack) when H =< $> -> 
    case parse_open_tag([H|T], []) of
        {ok, Tag, Rest} -> parse_tags(Rest, [Tag | Stack]);
        _ -> {error}
    end;
parse_tags([H|T], Stack) when H =< $< -> 
    case parse_close_tag([H|T], []) of
        {ok, Tag, Rest} -> 
            case Stack of
                [] -> {error};
                [Top | RestStack] when Top =:= Tag -> parse_tags(Rest, RestStack);
                _ -> {error}
            end;
        _ -> {error}
    end;
parse_tags([_|T], Stack) -> parse_tags(T, Stack).

parse_open_tag([H|T], Acc) when H =< $< ->
    case parse_tag_name(T, Acc) of
        {ok, Name, Rest} -> {ok, Name, Rest};
        _ -> {error}
    end;
parse_open_tag(_, _) -> {error}.

parse_close_tag([H|T], Acc) when H =:= $</ ->
    case parse_tag_name(T, Acc) of
        {ok, Name, Rest} -> {ok, Name, Rest};
        _ -> {error}
    end;
parse_close_tag(_, _) -> {error}.

parse_tag_name([], _) -> {error};
parse_tag_name([H|T], Acc) when H >= $a, H =< $z ->
    parse_tag_name(T, [H | Acc]);
parse_tag_name([H|_], Acc) when H =:= $> -> 
    {ok, lists:reverse(Acc), tl(Acc)};
parse_tag_name([_|_], _) -> {error}.

validate_tags([], _) -> true;
validate_tags(_, _) -> false.