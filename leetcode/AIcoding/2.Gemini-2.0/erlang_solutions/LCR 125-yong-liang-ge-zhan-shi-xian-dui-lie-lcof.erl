-module(book_arrange2).
-export([insert_book/2]).

insert_book(Books, NewBook) ->
  insert_book(Books, NewBook, []).

insert_book([], NewBook, Acc) ->
  lists:reverse([NewBook | Acc]);
insert_book([Book | Rest], NewBook, Acc) ->
  case NewBook < Book of
    true ->
      lists:reverse([NewBook | [Book | Rest] ++ Acc]);
    false ->
      insert_book(Rest, NewBook, [Book | Acc])
  end.