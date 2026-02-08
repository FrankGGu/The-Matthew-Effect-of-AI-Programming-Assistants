-module(extra_characters).
-export([minExtraChar/2]).

minExtraChar(S, Dictionary) ->
  minExtraChar(S, Dictionary, dict:new()).

minExtraChar(S, Dictionary, Memo) ->
  Len = length(S),
  minExtraChar_helper(S, 0, Len, Dictionary, Memo).

minExtraChar_helper(S, Start, Len, Dictionary, Memo) ->
  case dict:find(Start, Memo) of
    {ok, Value} ->
      Value;
    error ->
      case Start == Len of
        true ->
          0;
        false ->
          Result =
            lists:foldl(
              fun(Word, Acc) ->
                WordLen = length(Word),
                case Start + WordLen =< Len andalso lists:sublist(S, Start + 1, WordLen) == Word of
                  true ->
                    min(Acc, minExtraChar_helper(S, Start + WordLen, Len, Dictionary, Memo));
                  false ->
                    Acc
                end
              end,
              minExtraChar_helper(S, Start + 1, Len, Dictionary, Memo) + 1,
              Dictionary
            ),
          NewMemo = dict:store(Start, Result, Memo),
          NewMemoResult = Result,
          NewMemoResult
      end
  end.