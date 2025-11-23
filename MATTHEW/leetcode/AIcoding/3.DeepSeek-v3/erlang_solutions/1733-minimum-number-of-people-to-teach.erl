-module(solution).
-export([minimum_teach/3]).

minimum_teach(N, Languages, Friendships) ->
    LangMap = lists:foldl(fun([Id, Langs], Acc) ->
                                  maps:put(Id, sets:from_list(Langs), Acc)
                          end, #{}, Languages),
    NeedTeach = sets:new(),
    lists:foreach(fun([U, V]) ->
                      ULangs = maps:get(U, LangMap, sets:new()),
                      VLangs = maps:get(V, LangMap, sets:new()),
                      case sets:is_disjoint(ULangs, VLangs) of
                          true ->
                              sets:add_element(U, NeedTeach),
                              sets:add_element(V, NeedTeach);
                          false ->
                              ok
                      end
                  end, Friendships),
    case sets:size(NeedTeach) of
        0 -> 0;
        _ ->
            AllLangs = lists:seq(1, N),
            MinTeach = lists:min([lists:foldl(fun(Lang, Count) ->
                                                lists:foldl(fun(Person, Acc) ->
                                                                    case sets:is_element(Person, NeedTeach) andalso
                                                                         not sets:is_element(Lang, maps:get(Person, LangMap, sets:new())) of
                                                                        true -> Acc + 1;
                                                                        false -> Acc
                                                                    end
                                                            end, 0, sets:to_list(NeedTeach))
                                            end, 0, AllLangs)]),
            MinTeach
    end.