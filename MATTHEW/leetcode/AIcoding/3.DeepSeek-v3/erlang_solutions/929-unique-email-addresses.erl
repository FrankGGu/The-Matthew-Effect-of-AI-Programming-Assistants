-spec num_unique_emails(Emails :: [unicode:unicode_binary()]) -> integer().
num_unique_emails(Emails) ->
    Sets = sets:new(),
    lists:foldl(fun(Email, Acc) ->
        [Local, Domain] = binary:split(Email, <<"@">>),
        FilteredLocal = binary:replace(Local, <<".">>, <<"">>, [global]),
        PlusIndex = case binary:match(FilteredLocal, <<"+">>) of
            nomatch -> byte_size(FilteredLocal);
            {Pos, _} -> Pos
        end,
        ActualLocal = binary:part(FilteredLocal, 0, PlusIndex),
        NormalizedEmail = <<ActualLocal/binary, "@", Domain/binary>>,
        case sets:is_element(NormalizedEmail, Acc) of
            false -> sets:add_element(NormalizedEmail, Acc);
            true -> Acc
        end
    end, Sets, Emails),
    sets:size(Sets).