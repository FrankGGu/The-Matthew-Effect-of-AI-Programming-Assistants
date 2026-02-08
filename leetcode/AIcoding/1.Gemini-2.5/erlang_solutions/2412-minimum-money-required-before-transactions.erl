-module(solution).
-export([minimum_money/1]).

minimum_money(Transactions) ->
    {Gainers, Losers} = lists:partition(fun([Cost, Cashback]) -> Cost =< Cashback end, Transactions),

    % Sort gainers by cost in ascending order
    SortedGainers = lists:sort(fun([C1, _], [C2, _]) -> C1 =< C2 end, Gainers),
    % Sort losers by cost in descending order
    SortedLosers = lists:sort(fun([C1, _], [C2, _]) -> C1 >= C2 end, Losers),

    % Initialize Ans (minimum initial money) and CurrentMoney (money available relative to Ans)
    % CurrentMoney can be negative, indicating a deficit that Ans must cover.
    {Ans, _CurrentMoney} = lists:foldl(
        fun([Cost, Cashback], {AccAns, AccMoney}) ->
            Needed = Cost - AccMoney,
            % If CurrentMoney is less than Cost, we need to increase our initial Ans.
            % The amount to increase is Cost - CurrentMoney.
            % This ensures that by starting with AccAns, we have exactly Cost money
            % before this transaction.
            NewAccAns = AccAns + max(0, Needed),
            % Update CurrentMoney, accounting for the "top-up" from NewAccAns,
            % then performing the transaction.
            NewAccMoney = AccMoney + max(0, Needed) - Cost + Cashback,
            {NewAccAns, NewAccMoney}
        end,
        {0, 0}, % Initial state: {Ans, CurrentMoney}
        SortedGainers ++ SortedLosers
    ),
    Ans.