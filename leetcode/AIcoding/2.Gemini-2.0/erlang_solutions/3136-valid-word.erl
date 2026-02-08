-module(valid_word).
-export([solve/1]).

solve(Word) ->
  Dict = dict:from_list([
    {"a", 1}, {"b", 3}, {"c", 3}, {"d", 2}, {"e", 1},
    {"f", 4}, {"g", 2}, {"h", 4}, {"i", 1}, {"j", 8},
    {"k", 5}, {"l", 1}, {"m", 3}, {"n", 1}, {"o", 1},
    {"p", 3}, {"q", 10}, {"r", 1}, {"s", 1}, {"t", 1},
    {"u", 1}, {"v", 4}, {"w", 4}, {"x", 8}, {"y", 4},
    {"z", 10}
  ]),
  score(Word, Dict, 0).

score([], _Dict, Acc) ->
  Acc;
score([H|T], Dict, Acc) ->
  Letter = string:to_lower(string:substr([H],1,1)),
  case dict:find(Letter, Dict) of
    {ok, Value} ->
      score(T, Dict, Acc + Value);
    error ->
      score(T,Dict,Acc)
  end.