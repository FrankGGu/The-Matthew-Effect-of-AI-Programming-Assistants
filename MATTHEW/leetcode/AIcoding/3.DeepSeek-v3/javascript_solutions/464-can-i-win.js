var canIWin = function(maxChoosableInteger, desiredTotal) {
    if (maxChoosableInteger >= desiredTotal) return true;
    if ((maxChoosableInteger * (maxChoosableInteger + 1)) / 2 < desiredTotal) return false;

    const memo = new Map();

    function canWin(usedNumbers, remainingTotal) {
        if (memo.has(usedNumbers)) return memo.get(usedNumbers);

        for (let i = 1; i <= maxChoosableInteger; i++) {
            const mask = 1 << i;
            if ((usedNumbers & mask) === 0) {
                if (i >= remainingTotal || !canWin(usedNumbers | mask, remainingTotal - i)) {
                    memo.set(usedNumbers, true);
                    return true;
                }
            }
        }

        memo.set(usedNumbers, false);
        return false;
    }

    return canWin(0, desiredTotal);
};