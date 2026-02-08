-module(minimum_teach).
-export([minimum_teachings/2]).

minimum_teachings(N, Languages) ->
  People = lists:seq(1, length(Languages)),
  Common = find_common_languages(Languages),

  PeopleToTeach = lists:foldl(
    fun(Person, Acc) ->
      has_common_language(Person, Languages, Common) orelse lists:append(Acc, [Person])
    end,
    [],
    People
  ),

  languages_needed(PeopleToTeach, Languages, N).

find_common_languages(Languages) ->
  lists:foldl(
    fun(Lang, Acc) ->
      case Acc of
        [] -> Lang;
        _ -> sets:intersection(sets:from_list(Lang), sets:from_list(Acc))
      end
    end,
    [],
    Languages
  ).

has_common_language(Person, Languages, Common) ->
  PersonLanguages = lists:nth(Person - 1, Languages),
  sets:is_element_of(sets:from_list(PersonLanguages), sets:from_list(Common)).

languages_needed(PeopleToTeach, Languages, N) ->

  UniqueLanguages = lists:foldl(
    fun(Person, Acc) ->
      PersonLanguages = lists:nth(Person - 1, Languages),
      lists:foldl(
        fun(Lang, Acc2) ->
          case lists:member(Lang, Acc2) of
            true -> Acc2;
            false -> lists:append(Acc2, [Lang])
          end
        end,
        Acc,
        PersonLanguages
      )
    end,
    [],
    PeopleToTeach
  ),

  AllLanguages = lists:seq(1, N),

  LanguagesToTeach = lists:foldl(
    fun(Lang, Acc) ->
      Teach = lists:foldl(
        fun(Person, Acc2) ->
          PersonLanguages = lists:nth(Person - 1, Languages),
          lists:member(Lang, PersonLanguages) orelse Acc2
        end,
        false,
        PeopleToTeach
      ),

      case Teach of
        true -> Acc;
        false -> lists:append(Acc, [Lang])
      end
    end,
    [],
    AllLanguages
  ),

  length(LanguagesToTeach).