-module(tag_validator).
-export([is_valid/1]).

is_valid(Code) ->
    case Code of
        [] -> false;
        [Char|_] when Char =/= $< -> false; % Must start with '<'
        _ ->
            case parse_opening_tag_initial(Code) of
                {ok, TagName, RemString} ->
                    % Successfully parsed the first opening tag.
                    % Now parse the content and ensure the stack becomes empty at the end.
                    case parse_content(RemString, [TagName]) of
                        {ok, [], []} -> true; % Successfully parsed, string and stack are empty
                        _ -> false
                    end;
                _ -> false
            end
    end.

parse_opening_tag_initial([$<, TagNameChar|Rest]) ->
    case parse_tag_name([TagNameChar|Rest], []) of
        {ok, TagName, [$>|RemString]} ->
            if
                length(TagName) >= 1 andalso length(TagName) =< 9 andalso is_uppercase_tag(TagName) ->
                    {ok, TagName, RemString};
                true ->
                    {error, invalid_tag_name}
            end;
        _ -> {error, invalid_opening_tag_format}
    end;
parse_opening_tag_initial(_, _) -> {error, not_opening_tag}.

parse_content(String, TagStack) ->
    if
        String == [] ->
            {ok, [], TagStack}; % Reached end of string, return current state
        true ->
            case String of
                % Try to parse CDATA
                [ $<, $!, $[ , $C, $D, $A, $T, $A, $[ | _ ] = CDATA_Start ->
                    case parse_cdata(CDATA_Start) of
                        {ok, RemString} -> parse_content(RemString, TagStack);
                        {error, _} -> {error, cdata_parse_fail}
                    end;
                % Try to parse closing tag
                [ $<, $/ | _ ] = ClosingTagStart ->
                    case parse_closing_tag(ClosingTagStart, TagStack) of
                        {ok, RemString, NewTagStack} -> parse_content(RemString, NewTagStack);
                        {error, _} -> {error, closing_tag_parse_fail}
                    end;
                % Try to parse opening tag
                [ $< | _ ] = OpeningTagStart ->
                    case parse_opening_tag(OpeningTagStart, TagStack) of
                        {ok, RemString, NewTagStack} -> parse_content(RemString, NewTagStack);
                        {error, _} -> {error, opening_tag_parse_fail}
                    end;
                % If none of the above, it's regular content.
                % This is only allowed if TagStack is not empty.
                [_|Rest] ->
                    case TagStack of
                        [] -> {error, content_outside_tag}; % Should not happen if initial tag is handled correctly
                        [_|_] -> parse_content(Rest, TagStack)
                    end
            end
    end.

parse_cdata([$<, $!, $[, $C, $D, $A, $T, $A, $[ | Rest]) ->
    case string:str(Rest, "]]>") of
        0 -> {error, cdata_no_end}; % "]]>" not found
        Index ->
            % string:str returns 1-based index. "]]>" has length 3.
            % To get the string after "]]>", we skip Index + 3 - 1 = Index + 2 characters from Rest.
            {ok, lists:nthtail(Index + 2, Rest)}
    end;
parse_cdata(_, _) -> {error, not_cdata}.

parse_closing_tag([$<, $/, TagNameChar|Rest], TagStack) ->
    case parse_tag_name([TagNameChar|Rest], []) of
        {ok, TagName, [$>|RemString]} ->
            case TagStack of
                [] -> {error, closing_tag_no_open};
                [ExpectedTagName|RemainingStack] ->
                    if
                        TagName == ExpectedTagName ->
                            {ok, RemString, RemainingStack};
                        true ->
                            {error, tag_mismatch}
                    end
            end;
        _ -> {error, invalid_closing_tag_format}
    end;
parse_closing_tag(_, _) -> {error, not_closing_tag}.

parse_opening_tag([$<, TagNameChar|Rest], TagStack) ->
    case parse_tag_name([TagNameChar|Rest], []) of
        {ok, TagName, [$>|RemString]} ->
            if
                length(TagName) >= 1 andalso length(TagName) =< 9 andalso is_uppercase_tag(TagName) ->
                    {ok, RemString, [TagName|TagStack]};
                true ->
                    {error, invalid_tag_name}
            end;
        _ -> {error, invalid_opening_tag_format}
    end;
parse_opening_tag(_, _) -> {error, not_opening_tag}.

parse_tag_name(String, Acc) ->
    case String of
        [] -> {error, unexpected_end_of_string};
        [$>|Rest] ->
            {ok, lists:reverse(Acc), [$>|Rest]};
        [Char|Rest] when Char >= $A andalso Char =< $Z ->
            parse_tag_name(Rest, [Char|Acc]);
        _ -> {error, invalid_char_in_tag_name}
    end.

is_uppercase_tag(TagName) ->
    lists:all(fun(C) -> C >= $A andalso C =< $Z end, TagName).