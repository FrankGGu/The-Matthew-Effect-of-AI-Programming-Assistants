-module(valid_words).
-export([count_valid_words/1]).

count_valid_words(Sentence) ->
  Words = string:split(Sentence, " ", all),
  lists:foldl(fun(Word, Acc) ->
                  case is_valid_word(Word) of
                    true -> Acc + 1;
                    false -> Acc
                  end
              end, 0, Words).

is_valid_word(Word) ->
  case string:len(Word) of
    0 -> false;
    _ ->
      case re:run(Word, "^[a-z]+(-[a-z]+)?(!|\\.|,)?$", [{capture, all, list}]) of
        {match, _} ->
          HyphenCount = lists:foldl(fun(C, Acc) -> if C == $- then Acc + 1 else Acc end, 0, string:to_list(Word)),
          if HyphenCount > 1 then
            false
          else
            case re:run(Word, "-[a-z]+-", [{capture, all, list}]) of
              {match, _} -> false;
              nomatch ->
                case re:run(Word, "^-[a-z]+", [{capture, all, list}]) of
                  {match, _} -> false;
                  nomatch ->
                    case re:run(Word, "[a-z]+-$", [{capture, all, list}]) of
                      {match, _} -> false;
                      nomatch ->
                        true
                    end
                end
            end
          end;
        nomatch -> false
      end
  end.