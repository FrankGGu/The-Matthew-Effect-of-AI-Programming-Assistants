-module(minimum_number_of_people_to_teach).
-export([min_people/1]).

min_people(Preferences) ->
    People = lists:seq(1, length(Preferences)),
    Languages = lists:usort(lists:flatten(Preferences)),
    LanguageToPeople = maps:new(),
    LanguageToPeople2 = build_language_to_people(LanguageToPeople, Preferences, People),
    min_people(LanguageToPeople2, Languages, 0).

build_language_to_people(Acc, [], _) ->
    Acc;
build_language_to_people(Acc, [P | Ps], [Person | People]) ->
    build_language_to_people(build_language_to_people_for_person(Acc, P, Person), Ps, People).

build_language_to_people_for_person(Acc, Languages, Person) ->
    lists:foldl(fun(Language, AccIn) ->
        case maps:find(Language, AccIn) of
            {ok, People} ->
                maps:put(Language, [Person | People], AccIn);
            error ->
                maps:put(Language, [Person], AccIn)
        end
    end, Acc, Languages).

min_people(_, [], Result) ->
    Result;
min_people(LanguageToPeople, [Language | Languages], Result) ->
    People = maps:get(Language, LanguageToPeople),
    if
        length(People) == 1 ->
            min_people(LanguageToPeople, Languages, Result + 0);
        true ->
            min_people(LanguageToPeople, Languages, Result + 1)
    end.