sort_the_people(People, Heights) ->
    lists:zip(People, Heights)
    |> lists:sort(fun({_, H1}, {_, H2}) -> H1 > H2 end)
    |> lists:map(fun({P, _}) -> P end).