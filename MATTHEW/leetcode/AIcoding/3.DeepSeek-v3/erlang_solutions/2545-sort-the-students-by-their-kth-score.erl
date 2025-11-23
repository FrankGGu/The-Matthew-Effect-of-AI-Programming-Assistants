-spec sort_the_students(Scores :: [[integer()]], K :: integer()) -> [[integer()]].
sort_the_students(Scores, K) ->
    lists:reverse(lists:keysort(K + 1, Scores)).