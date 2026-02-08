-spec full_justify(Words :: [unicode:unicode_binary()], MaxWidth :: integer()) -> [unicode:unicode_binary()].

full_justify(Words, MaxWidth) ->
    full_justify(Words, MaxWidth, [], 0, []).

full_justify([], _, Acc, _, Result) -> lists:reverse(Result);
full_justify(Words, MaxWidth, CurrentLine, CurrentLength, Result) when CurrentLength =< MaxWidth ->
    case Words of
        [] -> lists:reverse([CurrentLine | Result]);
        [Word | Rest] ->
            WordLength = length(Word),
            case CurrentLength + WordLength + length(CurrentLine) > MaxWidth of
                true -> 
                    JustifiedLine = justify_line(CurrentLine, MaxWidth - CurrentLength, CurrentLength),
                    full_justify(Rest, MaxWidth, [Word], WordLength, [JustifiedLine | Result]);
                false -> 
                    full_justify(Rest, MaxWidth, [Word | CurrentLine], CurrentLength + WordLength, Result)
            end
    end.

justify_line(Line, SpacesToAdd, LineLength) ->
    case length(Line) > 1 of
        true -> 
            SpacesPerGap = div(SpacesToAdd, length(Line) - 1),
            ExtraSpaces = SpacesToAdd rem (length(Line) - 1),
            lists:foldl(fun(Word, Acc) ->
                case Acc of
                    [] -> [Word];
                    [Prev | Rest] ->
                        SpacedWord = Prev ++ lists:duplicate(SpacesPerGap, $ ) ++ Word,
                        case ExtraSpaces > 0 of
                            true -> SpacedWord ++ [$ ] | Rest;
                            false -> SpacedWord | Rest
                        end
                end
            end, [], Line);
        false -> 
            lists:flatten(Line) ++ lists:duplicate(SpacesToAdd, $ )
    end.
