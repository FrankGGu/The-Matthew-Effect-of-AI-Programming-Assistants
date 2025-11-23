-module(find_books).
-export([solve/0]).

solve() ->
    io:format("~s~n", [
        "SELECT b.book_id\n"
        "FROM Books b\n"
        "LEFT JOIN Orders o ON b.book_id = o.book_id\n"
        "GROUP BY b.book_id\n"
        "HAVING SUM(CASE WHEN o.dispatch_date IS NULL THEN 0 ELSE 1 END) >= b.quantity"
    ]).