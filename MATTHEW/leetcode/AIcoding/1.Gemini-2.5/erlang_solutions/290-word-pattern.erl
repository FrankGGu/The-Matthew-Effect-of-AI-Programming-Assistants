-module(solution).
-export([wordPattern/2]).

wordPattern(Pattern, S) ->
    PatternChars = Pattern,
    Words = string:tokens(S, " "),

    case length(PatternChars) == length(Words) of
        false -> false;
        true ->
            Pairs = lists:zip(PatternChars, Words),
            InitialState = {maps:new(), maps:new(), true},

            ResultState = lists:foldl(fun({Char, Word}, {CharToWordMap, WordToCharMap, Consistent}) ->
                                          if not Consistent ->
                                              {CharToWordMap, WordToCharMap, false};
                                             true ->
                                              case maps:find(Char, CharToWordMap) of
                                                  {ok, MappedWord} ->
                                                      if MappedWord == Word ->
                                                          case maps:find(Word, WordToCharMap) of
                                                              {ok, MappedChar} ->
                                                                  if MappedChar == Char ->
                                                                      {CharToWordMap, WordToCharMap, true};
                                                                     true ->
                                                                      {CharToWordMap, WordToCharMap, false}
                                                                  end;
                                                              error ->
                                                                  {CharToWordMap, WordToCharMap, false}
                                                          end;
                                                         true ->
                                                          {CharToWordMap, WordToCharMap, false}
                                                      end;
                                                  error ->
                                                      case maps:find(Word, WordToCharMap) of
                                                          {ok, MappedChar} ->
                                                              if MappedChar == Char ->
                                                                  {CharToWordMap, WordToCharMap, false};
                                                                 true ->
                                                                  {CharToWordMap, WordToCharMap, false}
                                                              end;
                                                          error ->
                                                              NewCharToWordMap = maps:put(Char, Word, CharToWordMap),
                                                              NewWordToCharMap = maps:put(Word, Char, WordToCharMap),
                                                              {NewCharToWordMap, NewWordToCharMap, true}
                                                      end
                                              end
                                          end
                                      end,
                                      InitialState,
                                      Pairs),

            element(3, ResultState)
    end.