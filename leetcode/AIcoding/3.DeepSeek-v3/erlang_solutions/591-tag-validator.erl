-module(solution).
-export([is_valid/1]).

is_valid(Code) ->
    case parse(Code) of
        {ok, _} -> true;
        _ -> false
    end.

parse(Code) ->
    case parse_tag(Code) of
        {ok, Rest} -> 
            case parse_cdata(Rest) of
                {ok, <<>>} -> {ok, []};
                {ok, Rest1} -> parse_content(Rest1);
                _ -> error
            end;
        _ -> error
    end.

parse_tag(<<"<![CDATA[", Rest/binary>>) -> parse_cdata(Rest);
parse_tag(<<"</", Rest/binary>>) -> parse_end_tag(Rest);
parse_tag(<<"<", Rest/binary>>) -> parse_start_tag(Rest);
parse_tag(Rest) -> parse_content(Rest).

parse_start_tag(Code) ->
    case parse_tag_name(Code) of
        {ok, TagName, <<">", Rest/binary>>} ->
            case parse_content(Rest) of
                {ok, Rest1} ->
                    case parse_end_tag(Rest1) of
                        {ok, <<"</", TagName/binary, ">", Rest2/binary>>} ->
                            {ok, Rest2};
                        _ -> error
                    end;
                _ -> error
            end;
        _ -> error
    end.

parse_end_tag(Code) ->
    case parse_tag_name(Code) of
        {ok, TagName, <<">", Rest/binary>>} -> {ok, Rest};
        _ -> error
    end.

parse_tag_name(Code) ->
    case binary:match(Code, <<">">>) of
        nomatch -> error;
        {Pos, _} ->
            TagName = binary:part(Code, 0, Pos),
            case valid_tag_name(TagName) of
                true -> {ok, TagName, binary:part(Code, Pos, byte_size(Code) - Pos)};
                false -> error
            end
    end.

valid_tag_name(TagName) ->
    case byte_size(TagName) of
        0 -> false;
        Len when Len > 9 -> false;
        _ -> valid_tag_name_chars(TagName)
    end.

valid_tag_name_chars(<<>>) -> true;
valid_tag_name_chars(<<C, Rest/binary>>) when C >= $A, C =< $Z ->
    valid_tag_name_chars(Rest);
valid_tag_name_chars(_) -> false.

parse_content(Code) ->
    case Code of
        <<>> -> {ok, <<>>};
        <<"<![CDATA[", Rest/binary>> ->
            case parse_cdata(Rest) of
                {ok, Rest1} -> parse_content(Rest1);
                _ -> error
            end;
        <<"</", _/binary>> -> {ok, Code};
        <<"<", _/binary>> ->
            case parse_tag(Code) of
                {ok, Rest} -> parse_content(Rest);
                _ -> error
            end;
        <<_:8, Rest/binary>> -> parse_content(Rest)
    end.

parse_cdata(Code) ->
    case binary:match(Code, <<"]]>">>) of
        nomatch -> error;
        {Pos, _} ->
            Rest = binary:part(Code, Pos + 3, byte_size(Code) - Pos - 3),
            {ok, Rest}
    end.