-module(vowel_spellchecker).
-export([spellchecker/2]).

spellchecker(WordList, Queries) ->
    LowerMap = maps:from_list([{string:to_lower(W), W} || W <- WordList]),
    VowelMap = maps:from_list([{vowelize(W), W} || W <- WordList]),
    [query(Word, LowerMap, VowelMap) || Word <- Queries].

query(Word, LowerMap, VowelMap) ->
    Lower = string:to_lower(Word),
    case maps:find(Lower, LowerMap) of
        {ok, W} -> W;
        error ->
            Vowel = vowelize(Word),
            case maps:find(Vowel, VowelMap) of
                {ok, W} -> W;
                error -> "None"
            end
    end.

vowelize(S) ->
    lists:map(fun(C) ->
                  case C of
                      $a -> $a;
                      $e -> $e;
                      $i -> $i;
                      $o -> $o;
                      $u -> $u;
                      _ -> $*
                  end
              end, S).