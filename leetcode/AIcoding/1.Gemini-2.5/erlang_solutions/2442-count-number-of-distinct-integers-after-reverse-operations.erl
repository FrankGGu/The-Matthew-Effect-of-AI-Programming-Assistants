-spec count_distinct_integers(Nums :: [integer()]) -> integer().
count_distinct_integers(Nums) ->
  ReversedNums = [list_to_integer(lists:reverse(integer_to_list(N))) || N <- Nums],
  AllNums = Nums ++ ReversedNums,
  sets:size(sets:from_list(AllNums)).