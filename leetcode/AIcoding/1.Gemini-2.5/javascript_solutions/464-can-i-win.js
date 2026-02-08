var canIWin = function(maxChoosableInteger, desiredTotal) {
    if (desiredTotal <= 0) {
        return true;
    }

    const totalSum = maxChoosableInteger * (maxChoosableInteger + 1) / 2;
    if (totalSum < desiredTotal) {
        return false;
    }

    const memo = new Map();

    function canWin(currentChosenMask, currentSum) {
        if (memo.has(currentChosenMask)) {
            return memo.get(currentChosenMask);
        }

        for (let i = 1; i <= maxChoosableInteger; i++) {
            const maskForI = (1 << (i - 1));
            if ((currentChosenMask & maskForI) === 0) { // If number i is not chosen yet
                // Current player chooses i
                if (currentSum + i >= desiredTotal) {
                    memo.set(currentChosenMask, true);
                    return true;
                }

                // If current player chooses i, and the NEXT player cannot win from the new state
                // (i.e., the next player loses), then the current player wins by making this move.
                if (!canWin(currentChosenMask | maskForI, currentSum + i)) {
                    memo.set(currentChosenMask, true);
                    return true;
                }
            }
        }

        // If no move leads to a win for the current player, then the current player loses.
        memo.set(currentChosenMask, false);
        return false;
    }

    return canWin(0, 0);
};