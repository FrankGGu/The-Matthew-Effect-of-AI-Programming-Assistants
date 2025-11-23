-module(vowel_spellchecker).
-export([spellchecker/2]).

spellchecker(Wordlist, Queries) ->
  Dict = build_dict(Wordlist),
  lists:map(fun(Query) -> check_query(Query, Dict) end, Queries).

build_dict(Wordlist) ->
  {lists:foldl(fun(Word, {Exact, Case, Vowel}) ->
                  {maps:put(Word, Word, Exact),
                   maps:put(string:to_lower(Word), Word, Case),
                   maps:put(vowel_mask(Word), Word, Vowel)}
              end, {maps:new(), maps:new(), maps:new()}, Wordlist)}.

check_query(Query, {Exact, Case, Vowel}) ->
  case maps:get(Query, Exact, not_found) of
    not_found ->
      case maps:get(string:to_lower(Query), Case, not_found) of
        not_found ->
          case maps:get(vowel_mask(Query), Vowel, not_found) of
            not_found ->
              ""
            Word ->
              Word
          end;
        Word ->
          Word
      end;
    Word ->
      Word
  end.

vowel_mask(Word) ->
  lists:map(fun(C) ->
                case lists:member(C, "aeiouAEIOU") of
                  true ->
                    '_';
                  false ->
                    C
                end
            end, string:to_lower(Word)).