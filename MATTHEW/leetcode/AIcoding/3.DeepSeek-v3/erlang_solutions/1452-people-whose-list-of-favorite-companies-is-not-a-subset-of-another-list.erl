-spec people_indexes(FavoriteCompanies :: [[binary()]]) -> [integer()].
people_indexes(FavoriteCompanies) ->
    Sets = [sets:from_list(FC) || FC <- FavoriteCompanies],
    Indices = lists:seq(0, length(FavoriteCompanies) - 1),
    lists:filter(fun(I) ->
        SetI = lists:nth(I + 1, Sets),
        not lists:any(fun(J) ->
            I =/= J andalso sets:is_subset(SetI, lists:nth(J + 1, Sets))
        end, Indices)
    end, Indices).