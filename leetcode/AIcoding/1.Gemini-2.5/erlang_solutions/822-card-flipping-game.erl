-module(solution).
-export([flipgame/2]).

-spec flipgame(Fronts :: [integer()], Backs :: [integer()]) -> integer().
flipgame(Fronts, Backs) ->
    Pairs = lists:zip(Fronts, Backs),

    % Step 1: Identify numbers that can never be good (BadSet).
    % A number X is in BadSet if there's any card i where Fronts[i] == X and Backs[i] == X.
    % Such a number X will always appear on the back of card i, regardless of flipping.
    BadSet = lists:foldl(
        fun({F, B}, AccSet) ->
            if F == B -> sets:add_element(F, AccSet);
               true -> AccSet
            end
        end,
        sets:new(),
        Pairs
    ),

    % Step 2: Collect all unique numbers that appear on any side of any card (AllNumbersSet).
    AllNumbersSet = sets:union(sets:from_list(Fronts), sets:from_list(Backs)),

    % Step 3: The set of potential good numbers.
    % Any number X not in BadSet can be made to appear on the front of a card
    % (if it's on any side of any card) and not on the back of any card.
    % We achieve this by:
    % - If a card has X on front and Y on back (X /= Y), don't flip. X is on front, Y on back.
    % - If a card has Y on front and X on back (X /= Y), flip it. X is on front, Y on back.
    % - If a card doesn't have X on either side, it doesn't affect X being on the back.
    % So, any number in AllNumbersSet but not in BadSet is a potential good number.
    PotentialGoodNumbersList = sets:to_list(sets:subtract(AllNumbersSet, BadSet)),

    % Step 4: Find the minimum of potential good numbers.
    % If the list is empty, it means no good integer exists, return 0 as per problem description.
    if PotentialGoodNumbersList == [] -> 0;
       true -> lists:min(PotentialGoodNumbersList)
    end.