-spec count_substrings(S :: unicode:unicode_binary(), K :: integer()) -> integer().
count_substrings(S, K) ->
    Vowels = sets:from_list("aeiou"),
    SList = unicode:characters_to_list(S),
    N = length(SList),
    Count = 0,
    {Total, _} = lists:foldl(fun(I, {Acc, Prefix}) ->
        VowelSet = sets:new(),
        ConsonantCount = 0,
        {NewAcc, NewPrefix} = lists:foldl(fun(J, {InnerAcc, {VSet, CCount}}) ->
            Char = lists:nth(J, SList),
            case sets:is_element(Char, Vowels) of
                true ->
                    NewVSet = sets:add_element(Char, VSet),
                    case sets:size(NewVSet) =:= 5 andalso (J - I + 1 - sets:size(NewVSet)) =:= K of
                        true -> {InnerAcc + 1, {NewVSet, CCount}};
                        false -> {InnerAcc, {NewVSet, CCount}}
                    end;
                false ->
                    NewCCount = CCount + 1,
                    case sets:size(VSet) =:= 5 andalso NewCCount =:= K of
                        true -> {InnerAcc + 1, {VSet, NewCCount}};
                        false -> {InnerAcc, {VSet, NewCCount}}
                    end
            end
        end, {0, {VowelSet, ConsonantCount}}, lists:seq(I, N)),
        {Acc + NewAcc, Prefix}
    end, {0, {}}, lists:seq(1, N)),
    Total.