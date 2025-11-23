-module(solution).
-export([minimumTeachings/3]).

minimumTeachings(N, Languages, Friendships) ->
    PersonLangsArray = array:from_list([sets:from_list(L) || L <- Languages]),

    UncommunicativePairs = lists:filter(
        fun([P1, P2]) ->
            P1_idx = P1 - 1,
            P2_idx = P2 - 1,
            LangsP1Set = array:get(P1_idx, PersonLangsArray),
            LangsP2Set = array:get(P2_idx, PersonLangsArray),
            sets:is_empty(sets:intersection(LangsP1Set, LangsP2Set))
        end,
        Friendships
    ),

    case UncommunicativePairs of
        [] -> 0;
        _ ->
            MaxLangId = lists:foldl(fun(Langs, Max) ->
                                        lists:foldl(fun(Lang, CurrentMax) ->
                                                        max(Lang, CurrentMax)
                                                    end, Max, Langs)
                                    end, 0, Languages),

            MinPeopleToTeach = lists:foldl(
                fun(TeachLang, CurrentMin) ->
                    PeopleToTeachForThisLang = lists:foldl(
                        fun([P1, P2], AccSet) ->
                            P1_idx = P1 - 1,
                            P2_idx = P2 - 1,
                            LangsP1Set = array:get(P1_idx, PersonLangsArray),
                            LangsP2Set = array:get(P2_idx, PersonLangsArray),

                            P1_speaks_teach_lang = sets:is_element(TeachLang, LangsP1Set),
                            P2_speaks_teach_lang = sets:is_element(TeachLang, LangsP2Set),

                            AccSet1 = if not P1_speaks_teach_lang -> sets:add_element(P1, AccSet);
                                      true -> AccSet
                                    end,
                            AccSet2 = if not P2_speaks_teach_lang -> sets:add_element(P2, AccSet1);
                                      true -> AccSet1
                                    end,
                            AccSet2
                        end,
                        sets:new(),
                        UncommunicativePairs
                    ),
                    min(CurrentMin, sets:size(PeopleToTeachForThisLang))
                end,
                N + 1,
                lists:seq(1, MaxLangId)
            ),
            MinPeopleToTeach
    end.