-spec string_matching(Words :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
string_matching(Words) ->
    lists:usort(
        lists:foldl(fun(Word, Acc) ->
            lists:foldl(fun(OtherWord, InnerAcc) ->
                case binary:match(OtherWord, Word) =/= nomatch andalso OtherWord =/= Word of
                    true -> [Word | InnerAcc];
                    false -> InnerAcc
                end
            end, Acc, Words)
        end, [], Words)
    ).