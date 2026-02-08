-spec change_data_type(Students :: [[term()]]) -> [[term()]].
change_data_type(Students) ->
    lists:map(fun([Id, Name, Age]) ->
        [Id, Name, list_to_integer(Age)]
    end, Students).