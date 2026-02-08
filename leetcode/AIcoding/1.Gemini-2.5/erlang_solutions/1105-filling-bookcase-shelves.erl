-module(solution).
-export([solve/2]).

solve(Books, ShelfWidth) ->
    N = length(Books),
    % Convert the list of books to a map for O(log N) access by index.
    % Keys are 0-indexed book numbers, values are {Width, Height} tuples.
    BooksMap = lists:foldl(fun({Book, Idx}, Acc) -> Acc#{Idx => Book} end, #{}, lists:zip(Books, lists:seq(0, N-1))),

    % DpMap stores Dp[i], which is the minimum height to place the first 'i' books.
    % Keys are the number of books placed (from 0 to N).
    % Values are the minimum total height.
    DpMap = lists:foldl(
        fun(I, CurrentDpMap) ->
            % Calculate Dp[I] based on previous Dp values.
            MinHeightForI = calculate_dp_i(I, BooksMap, ShelfWidth, CurrentDpMap),
            CurrentDpMap#{I => MinHeightForI}
        end,
        #{0 => 0}, % Base case: 0 books require 0 height.
        lists:seq(1, N) % Iterate from 1 to N to calculate Dp[1] through Dp[N].
    ),

    % The final answer is Dp[N], the minimum height for all N books.
    maps:get(N, DpMap).

calculate_dp_i(I, BooksMap, ShelfWidth, DpMap) ->
    % Initialize min height for Dp[I] to a very large number (infinity).
    Infinity = 1_000_000_000, 

    % Start the inner loop: iterate backwards from the (I-1)-th book (0-indexed)
    % to determine which books go on the current (last) shelf.
    % J represents the 0-indexed book index.
    % Books from J to (I-1) are considered for the current shelf.
    calculate_dp_i_inner(I-1, BooksMap, ShelfWidth, DpMap, Infinity, 0, 0).

calculate_dp_i_inner(J, BooksMap, ShelfWidth, DpMap, AccMinHeight, AccCurrentWidth, AccMaxHeightOnShelf) when J >= 0 ->
    % Get the current book's details.
    Book = maps:get(J, BooksMap),
    BookWidth = element(1, Book),
    BookHeight = element(2, Book),

    NewCurrentWidth = AccCurrentWidth + BookWidth,
    NewMaxHeightOnShelf = max(AccMaxHeightOnShelf, BookHeight),

    if
        NewCurrentWidth > ShelfWidth ->
            % If adding Book J exceeds the shelf width, this combination is invalid.
            % We cannot place Book J and further left books on this shelf.
            % Return the best minimum height found so far without this book.
            AccMinHeight;
        true ->
            % If the current shelf width is valid, calculate the total height
            % if books from J to (I-1) are placed on the current shelf.
            % This height is Dp[J] (min height for first J books) + NewMaxHeightOnShelf.
            PrevDpVal = maps:get(J, DpMap),
            NewMinHeight = min(AccMinHeight, PrevDpVal + NewMaxHeightOnShelf),

            % Recursively call for the next book to the left (J-1),
            % trying to place more books on the current shelf.
            calculate_dp_i_inner(J-1, BooksMap, ShelfWidth, DpMap, NewMinHeight, NewCurrentWidth, NewMaxHeightOnShelf)
    end;
calculate_dp_i_inner(_J, _BooksMap, _ShelfWidth, _DpMap, AccMinHeight, _AccCurrentWidth, _AccMaxHeightOnShelf) ->
    AccMinHeight.