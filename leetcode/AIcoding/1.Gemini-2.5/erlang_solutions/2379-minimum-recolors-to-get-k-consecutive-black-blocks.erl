-module(solution).
-export([minimumRecolors/2]).

minimumRecolors(Blocks, K) ->
    BlocksList = string:to_list(Blocks),
    N = length(BlocksList),
    if
        N < K -> 0;
        true ->
            % Calculate the number of 'W's in the first window of size K
            InitialWindow = lists:sublist(BlocksList, 1, K),
            InitialWhites = count_whites(InitialWindow),

            % LeftStream: The original list, its head is the character leaving the window.
            % RightStream: The remaining characters that will enter the window.
            % lists:nthtail(K, BlocksList) gives the list starting from the (K+1)-th element.
            slide_window(BlocksList, lists:nthtail(K, BlocksList), InitialWhites, InitialWhites)
    end.

count_whites(Chars) ->
    lists:foldl(fun(Char, Acc) ->
                    if Char == $W -> Acc + 1; true -> Acc end
                end, 0, Chars).

slide_window(_LeftStream, [], _CurrentWhites, MinWhites) ->
    % Base case: No more characters to enter the window, so no more windows to check.
    MinWhites;
slide_window([LeftChar | NextLeftStream], [NextChar | NextRightStream], CurrentWhites, MinWhites) ->
    % Update CurrentWhites:
    % 1. Subtract 1 if the character leaving (LeftChar) was 'W'.
    NewWhites1 = if LeftChar == $W -> CurrentWhites - 1; true -> CurrentWhites end,
    % 2. Add 1 if the character entering (NextChar) is 'W'.
    NewWhites2 = if NextChar == $W -> NewWhites1 + 1; true -> NewWhites1 end,

    % Update MinWhites with the new minimum
    NewMinWhites = min(MinWhites, NewWhites2),

    % Recurse: slide the window one position to the right
    slide_window(NextLeftStream, NextRightStream, NewWhites2, NewMinWhites).