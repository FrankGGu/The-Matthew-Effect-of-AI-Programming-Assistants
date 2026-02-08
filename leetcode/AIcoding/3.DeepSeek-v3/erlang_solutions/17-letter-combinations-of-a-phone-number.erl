-spec letter_combinations(Digits :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
letter_combinations(Digits) ->
    case Digits of
        <<>> -> [];
        _ ->
            Map = #{
                $2 => "abc",
                $3 => "def",
                $4 => "ghi",
                $5 => "jkl",
                $6 => "mno",
                $7 => "pqrs",
                $8 => "tuv",
                $9 => "wxyz"
            },
            combine(Digits, Map)
    end.

combine(Digits, Map) ->
    combine(Digits, Map, [<<>>]).

combine(<<>>, _, Acc) ->
    lists:reverse(Acc);
combine(<<Digit:8, Rest/binary>>, Map, Acc) ->
    Letters = maps:get(Digit, Map),
    NewAcc = lists:foldl(
        fun(Letter, AccIn) ->
            lists:foldl(
                fun(Str, AccInIn) ->
                    [<<Str/binary, Letter>> | AccInIn]
                end,
                AccIn,
                Acc
            )
        end,
        [],
        Letters
    ),
    combine(Rest, Map, NewAcc).