-module(solution).
-export([new/3, encrypt/2, decrypt/2]).

-record(encrypter, {
    key_map :: map(), % char() -> string() (2-char)
    encrypted_dict_words :: [string()]
}).

new(Keys, Values, Dictionary) ->
    KeyMap = maps:from_list(lists:zip(Keys, Values)),
    EncryptedDictWords = lists:map(fun(Word) -> encrypt_word_internal(Word, KeyMap) end, Dictionary),
    #encrypter{key_map = KeyMap, encrypted_dict_words = EncryptedDictWords}.

encrypt(EncrypterState, Word1) ->
    KeyMap = EncrypterState#encrypter.key_map,
    encrypt_word_internal(Word1, KeyMap).

encrypt_word_internal(Word, KeyMap) ->
    try
        lists:foldl(fun(C, Acc) ->
            case maps:get(C, KeyMap, undefined) of
                undefined -> throw(no_mapping);
                V -> Acc ++ V
            end
        end, "", Word)
    catch
        throw:no_mapping -> ""
    end.

decrypt(EncrypterState, Word2) ->
    EncryptedDictWords = EncrypterState#encrypter.encrypted_dict_words,
    lists:sum(lists:map(fun(EncryptedWord) -> if EncryptedWord == Word2 -> 1; true -> 0 end end, EncryptedDictWords)).