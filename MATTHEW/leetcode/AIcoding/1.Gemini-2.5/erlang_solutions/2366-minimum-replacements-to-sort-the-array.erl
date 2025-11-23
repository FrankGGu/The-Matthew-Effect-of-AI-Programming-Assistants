-spec minimum_replacements(Nums :: [integer()]) -> integer().
minimum_replacements(Nums) ->
    ReversedNums = lists:reverse(Nums),

    % The accumulator is a tuple {TotalReplacements, CurrentRightmostValue}.
    % CurrentRightmostValue is the value that the element to its left must be less than or equal to.
    % For the rightmost element of the original array (first in ReversedNums),
    % it doesn't need to be split against anything to its right.
    % So, we initialize with 0 replacements and its own value as the CurrentRightmostValue.
    InitialAcc = {0, hd(ReversedNums)},

    % We fold over the rest of the reversed list (excluding the first element which initialized InitialAcc).
    Fun = fun(CurrentElement, {AccReplacements, AccLastElement}) ->
        if
            CurrentElement =< AccLastElement ->
                % No split needed, CurrentElement is already <= AccLastElement.
                % The new CurrentRightmostValue for the next iteration (element to the left) is CurrentElement itself.
                {AccReplacements, CurrentElement};
            true ->
                % CurrentElement > AccLastElement, a split is needed.
                % Calculate K, the number of parts CurrentElement must be split into.
                % K = ceil(CurrentElement / AccLastElement)
                % Using integer division: ceil(A/B) = (A + B - 1) div B
                K = (CurrentElement + AccLastElement - 1) div AccLastElement,

                % Each split operation adds K-1 replacements.
                NewReplacements = AccReplacements + (K - 1),

                % After splitting CurrentElement into K parts, the smallest possible part
                % is floor(CurrentElement / K). This smallest part becomes the new
                % CurrentRightmostValue for the element to its left, to maintain non-decreasing order.
                NewLastElement = CurrentElement div K,

                {NewReplacements, NewLastElement}
        end
    end,

    {Replacements, _LastElement} = lists:foldl(Fun, InitialAcc, tl(ReversedNums)),
    Replacements.