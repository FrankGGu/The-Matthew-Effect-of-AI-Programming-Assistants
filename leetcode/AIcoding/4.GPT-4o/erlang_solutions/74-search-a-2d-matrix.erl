-spec search_matrix(Matrix :: [[integer()]], Target :: integer()) -> boolean().
search_matrix([], _) -> false;
search_matrix([Row | Rest], Target) ->
    case binary_search(Row, Target) of
        true -> true;
        false -> search_matrix(Rest, Target)
    end.

-spec binary_search(Row :: [integer()], Target :: integer()) -> boolean().
binary_search([], _) -> false;
binary_search([Head | Tail], Target) when Head == Target -> true;
binary_search([Head | Tail], Target) when Head > Target -> false;
binary_search([_ | Tail], Target) -> binary_search(Tail, Target).
