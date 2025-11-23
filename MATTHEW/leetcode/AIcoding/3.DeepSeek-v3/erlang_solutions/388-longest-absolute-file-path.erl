-spec length_longest_path(Input :: unicode:unicode_binary()) -> integer().
length_longest_path(Input) ->
    Lines = binary:split(Input, <<"\n">>, [global]),
    Stack = [],
    MaxLen = 0,
    {_, Result} = lists:foldl(fun(Line, {StackAcc, MaxLenAcc}) ->
        Name = Line,
        Level = count_tabs(Name),
        CleanName = strip_tabs(Name, Level),
        IsFile = is_file(CleanName),
        NewStack = case length(StackAcc) of
            L when L > Level -> lists:sublist(StackAcc, Level);
            _ -> StackAcc
        end,
        CurrentLen = case NewStack of
            [] -> byte_size(CleanName);
            _ -> lists:sum([byte_size(N) || N <- NewStack]) + byte_size(CleanName) + length(NewStack)
        end,
        NewMax = case IsFile of
            true -> max(MaxLenAcc, CurrentLen);
            false -> MaxLenAcc
        end,
        NewStackAcc = case IsFile of
            false -> NewStack ++ [CleanName];
            true -> NewStack
        end,
        {NewStackAcc, NewMax}
    end, {Stack, MaxLen}, Lines),
    Result.

count_tabs(Line) ->
    count_tabs(Line, 0).

count_tabs(<<$\t, Rest/binary>>, Count) ->
    count_tabs(Rest, Count + 1);
count_tabs(_, Count) ->
    Count.

strip_tabs(Line, Level) ->
    strip_tabs(Line, Level, <<>>).

strip_tabs(Line, 0, Acc) ->
    <<Acc/binary, Line/binary>>;
strip_tabs(<<$\t, Rest/binary>>, Level, Acc) when Level > 0 ->
    strip_tabs(Rest, Level - 1, Acc);
strip_tabs(Line, _, Acc) ->
    <<Acc/binary, Line/binary>>.

is_file(Name) ->
    case binary:match(Name, <<".">>) of
        nomatch -> false;
        _ -> true
    end.