-spec create_dataframe(Columns :: [[term()]]) -> #{atom() => [term()]}.
create_dataframe(Columns) ->
    [Student, Age] = Columns,
    #{student => Student, age => Age}.