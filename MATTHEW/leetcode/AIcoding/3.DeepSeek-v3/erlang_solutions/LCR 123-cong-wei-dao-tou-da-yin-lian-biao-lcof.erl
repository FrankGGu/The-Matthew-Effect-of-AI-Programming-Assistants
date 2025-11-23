-spec reverse_book_list(Head :: list()) -> list().
reverse_book_list(Head) ->
    reverse(Head, []).

reverse([], Acc) -> Acc;
reverse([H | T], Acc) -> reverse(T, [H | Acc]).