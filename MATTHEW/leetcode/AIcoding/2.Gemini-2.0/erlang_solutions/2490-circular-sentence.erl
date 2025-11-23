-module(circular_sentence).
-export([is_circular_sentence/1]).

is_circular_sentence(Sentence) ->
  Words = string:split(Sentence, " ", all),
  is_circular_sentence_helper(Words).

is_circular_sentence_helper([Word]) ->
  true;
is_circular_sentence_helper([First | Rest]) ->
  case Rest of
    [Second | _] ->
      FirstLast = string:last(First),
      SecondFirst = string:head(Second),
      if FirstLast == SecondFirst ->
        is_circular_sentence_helper([Second | tl(Rest)])
      else
        false
      end;
    [] ->
      FirstLast = string:last(First),
      SentenceFirst = string:head(lists:nth(1, string:split(list_to_binary(First), " ", all))),
      FirstLast == SentenceFirst
  end.