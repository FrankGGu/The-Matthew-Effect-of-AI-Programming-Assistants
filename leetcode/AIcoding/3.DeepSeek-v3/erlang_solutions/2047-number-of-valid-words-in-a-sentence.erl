-module(solution).
-export([count_valid_words/1]).

count_valid_words(Sentence) ->
    Tokens = string:tokens(Sentence, " "),
    lists:foldl(fun(Token, Acc) ->
        case is_valid(Token) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Tokens).

is_valid(Token) ->
    case re:run(Token, "^([a-z]+(-[a-z]+)?)?[!.,]?$") of
        {match, _} -> 
            case string:chr(Token, $-) of
                0 -> true;
                Pos ->
                    (Pos > 1) andalso (Pos < length(Token)) andalso
                    (lists:nth(Pos - 1, Token) >= $a) andalso (lists:nth(Pos - 1, Token) =< $z) andalso
                    (lists:nth(Pos + 1, Token) >= $a) andalso (lists:nth(Pos + 1, Token) =< $z)
            end;
        nomatch -> false
    end.