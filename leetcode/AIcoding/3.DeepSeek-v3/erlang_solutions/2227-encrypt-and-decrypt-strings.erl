-module(encrypt_decrypt).
-export([encrypt/1, decrypt/1, encrypt_words/2, decrypt_words/2]).

encrypt(Word) ->
    lists:foldl(fun(Char, Acc) -> 
        case Char of
            $a -> [$0 | Acc];
            $e -> [$1 | Acc];
            $i -> [$2 | Acc];
            $o -> [$3 | Acc];
            $u -> [$4 | Acc];
            _ -> [Char | Acc]
        end
    end, [], Word).

decrypt(Word) ->
    lists:foldl(fun(Char, Acc) -> 
        case Char of
            $0 -> [$a | Acc];
            $1 -> [$e | Acc];
            $2 -> [$i | Acc];
            $3 -> [$o | Acc];
            $4 -> [$u | Acc];
            _ -> [Char | Acc]
        end
    end, [], Word).

encrypt_words(Words, Keys) ->
    lists:map(fun(Word) -> encrypt(Word) end, Words).

decrypt_words(Words, Keys) ->
    lists:map(fun(Word) -> decrypt(Word) end, Words).