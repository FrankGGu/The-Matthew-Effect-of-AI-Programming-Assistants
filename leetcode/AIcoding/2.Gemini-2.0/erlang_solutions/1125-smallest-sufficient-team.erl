-module(smallest_sufficient_team).
-export([smallestSufficientTeam/2]).

smallestSufficientTeam(req_skills, people) ->
  SkillsMap = lists:foldl(fun(Skill, Acc) ->
                                 maps:put(Skill, maps:size(Acc), Acc)
                             end, #{}, req_skills),
  N = length(req_skills),
  MPeople = [lists:foldl(fun(Skill, Acc) ->
                                 maps:get(Skill, SkillsMap) bor Acc
                             end, 0, Person) || Person <- people],

  Memo = dict:new(),

  F = fun(Mask, I, Rec) ->
        case dict:find({Mask, I}, Memo) of
          {ok, Val} ->
            Val;
          error ->
            case Mask == (1 bsl N) - 1 of
              true ->
                dict:store({Mask, I}, [], Memo),
                [];
              false ->
                case I >= length(people) of
                  true ->
                    dict:store({Mask, I}, "INF", Memo),
                    "INF";
                  false ->
                    Without = Rec(Mask, I + 1),
                    WithMask = Mask bor lists:nth(I + 1, MPeople),
                    With = Rec(WithMask, I + 1),
                    case Without == "INF" of
                      true ->
                        case With == "INF" of
                          true ->
                            dict:store({Mask, I}, "INF", Memo),
                            "INF";
                          false ->
                            dict:store({Mask, I}, [I | With], Memo),
                            [I | With];
                        end;
                      false ->
                        case With == "INF" of
                          true ->
                            dict:store({Mask, I}, Without, Memo),
                            Without;
                          false ->
                            case length(Without) =< length(With) of
                              true ->
                                dict:store({Mask, I}, Without, Memo),
                                Without;
                              false ->
                                dict:store({Mask, I}, [I | With], Memo),
                                [I | With];
                            end;
                        end;
                    end
                end
            end
        end
      end,
  lists:sort(F(0, 0, F)).