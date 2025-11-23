-module(find_sequence).
-export([find_sequence/1]).

find_sequence(S) ->
  find_sequence_helper(S, []).

find_sequence_helper([], Acc) ->
  lists:reverse(Acc);
find_sequence_helper(S, Acc) ->
  case find_first_string(S) of
    {ok, String, Rest} ->
      find_sequence_helper(Rest, [String | Acc]);
    error ->
      lists:reverse(Acc)
  end.

find_first_string(S) ->
  Candidates = ["AB", "AC", "B", "BA", "BC", "C", "CA", "CB"],
  find_best_match(S, Candidates).

find_best_match(S, []) ->
  error;
find_best_match(S, [Candidate | Rest]) ->
  case string:str(S, Candidate) of
    0 ->
      find_best_match(S, Rest);
    Pos ->
      {ok, Candidate, string:substr(S, Pos + string:len(Candidate))}
  end.