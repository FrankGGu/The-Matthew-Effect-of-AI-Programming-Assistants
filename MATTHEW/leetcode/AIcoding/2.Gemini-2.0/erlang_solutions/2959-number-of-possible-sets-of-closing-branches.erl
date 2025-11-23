-module(possible_sets).
-export([number_of_ways/2]).

number_of_ways(N, Restrictions) ->
  number_of_ways(N, Restrictions, 0, 1).

number_of_ways(N, Restrictions, Mask, Count) when Mask == 1 bsl N ->
  Count;
number_of_ways(N, Restrictions, Mask, Count) ->
  NewCount1 = number_of_ways(N, Restrictions, Mask bsl 1, Count),
  Node = integer_to_list(Mask bsr 0 + 1),

  CanClose = lists:all(fun({A, B}) ->
                        not (
                           (A == list_to_integer(Node) and (Mask bsr (B - 1) band 1) == 1)
                           or
                           (B == list_to_integer(Node) and (Mask bsr (A - 1) band 1) == 1)
                          )
                      end, Restrictions),

  NewCount2 = case CanClose of
                true -> number_of_ways(N, Restrictions, (Mask bsl 1) bor 1, Count + 1);
                false -> 0
              end,

  NewCount1 + NewCount2.