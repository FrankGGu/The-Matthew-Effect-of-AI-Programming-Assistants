-module(solution).
-export([divide_players/1]).

divide_players(Skill) ->
  SortedSkills = lists:sort(Skill),
  Len = length(SortedSkills),
  case Len rem 2 of
    0 ->
      Sum = lists:nth(1, SortedSkills) + lists:nth(Len, SortedSkills),
      {Result, _} = lists:foldl(
        fun(I, {Acc, PrevSum}) ->
          Skill1 = lists:nth(I, SortedSkills),
          Skill2 = lists:nth(Len - I + 1, SortedSkills),
          CurrentSum = Skill1 + Skill2,
          if CurrentSum =/= Sum then
            {error, _}
          else
            {Acc + Skill1 * Skill2, CurrentSum}
          end
        end,
        {0, Sum},
        lists:seq(1, Len div 2)
      ),
      case Result of
        error ->
          -1;
        _ ->
          Result
      end;
    _ ->
      -1
  end.