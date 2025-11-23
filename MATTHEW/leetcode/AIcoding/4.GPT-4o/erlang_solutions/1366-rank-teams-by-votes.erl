-module(solution).
-export([rank_teams/1]).

rank_teams(Votes) ->
    Teams = lists:foldl(fun(Vote, Acc) -> 
                            lists:foldl(fun({Char, Index}) -> 
                                            lists:insert_sort({Char, Index + 1}, Acc) 
                                        end, Acc, lists:zip(Vote, lists:seq(0, length(Vote) - 1)))
                        end, [], Votes),
    lists:map(fun({Char, _}) -> Char end, lists:sort(fun({C1, V1}, {C2, V2}) -> 
                                                          case V1 - V2 of 
                                                              0 -> C1 < C2; 
                                                              _ -> V1 > V2 
                                                          end 
                                                      end, Teams)).

insert_sort(Element, []) -> [Element];
insert_sort({Char, Count}, [{C, V} | Rest]) when Count > V -> [{Char, Count}, {C, V} | Rest];
insert_sort(Element, [Head | Tail]) -> [Head | insert_sort(Element, Tail)].