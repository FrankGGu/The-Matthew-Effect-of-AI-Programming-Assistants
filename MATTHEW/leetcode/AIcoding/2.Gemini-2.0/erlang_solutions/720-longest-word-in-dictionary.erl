-module(longest_word).
-export([longest_word/1]).

longest_word(Dict) ->
  longest_word(Dict, []).

longest_word([], Acc) ->
  case Acc of
    [] -> "";
    _ -> lists:foldl(fun(A, B) ->
                        case string:len(A) > string:len(B) of
                          true -> A;
                          false ->
                            case string:len(A) == string:len(B) andalso A < B of
                              true -> A;
                              false -> B
                            end
                        end
                      end, hd(Acc), tl(Acc))
  end.

longest_word([Word | Rest], Acc) ->
  case is_buildable(Word, lists:usort(Rest)) of
    true -> longest_word(Rest, [Word | Acc]);
    false -> longest_word(Rest, Acc)
  end.

is_buildable("", _) -> true;
is_buildable(Word, Dict) ->
  case string:len(Word) of
    0 -> true;
    _ ->
      Sub = string:sub(Word, 1, string:len(Word) -1),
      case (lists:member(Sub, Dict) or Sub == "") of
        true -> true;
        false -> false
      end andalso is_buildable(Sub, Dict).