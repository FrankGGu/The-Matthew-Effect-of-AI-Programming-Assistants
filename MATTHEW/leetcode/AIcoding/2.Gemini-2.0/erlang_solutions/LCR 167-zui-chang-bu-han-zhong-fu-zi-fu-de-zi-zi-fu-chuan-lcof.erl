-module(solution).
-export([crack_skill/1]).

crack_skill(skills) ->
  crack_skill(skills, []).

crack_skill([], Acc) ->
  lists:reverse(Acc);
crack_skill([H|T], Acc) ->
  case crack_skill_helper(H) of
    true -> crack_skill(T, [H|Acc]);
    false -> crack_skill(T, Acc)
  end.

crack_skill_helper(Skill) ->
  crack_skill_helper(Skill, "abcdef").

crack_skill_helper("", _) ->
  true;
crack_skill_helper([H|T], Valid) ->
  case string:chr(Valid, H) of
    nomatch -> false;
    _ -> crack_skill_helper(T, Valid)
  end.