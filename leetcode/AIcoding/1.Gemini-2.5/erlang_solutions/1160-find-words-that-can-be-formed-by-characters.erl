-module(solution).
-export([sum_lengths_of_good_words/2]).

sum_lengths_of_good_words(Words, Chars) ->
    CharMap = count_chars(Chars),
    lists:foldl(fun(Word, Acc) ->
                    if can_form_word(Word, CharMap) ->
                           Acc + length(Word);
                       true ->
                           Acc
                    end
                end, 0, Words).

count_chars(Str) ->
    lists:foldl(fun(C, Acc) ->
                    maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                end, maps:new(), Str).

can_form_word(Word, CharMap) ->
    WordCharMap = count_chars(Word),
    lists:all(fun({C, CountW}) ->
                  case maps:find(C, CharMap) of
                      {ok, CountC} -> CountC >= CountW;
                      error -> false
                  end
              end, maps:to_list(WordCharMap)).