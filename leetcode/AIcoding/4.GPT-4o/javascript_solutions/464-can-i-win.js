var canIWin = function(maxChoosableInteger, desiredTotal) {
    if (desiredTotal <= 0) return true;
    if ((maxChoosableInteger * (maxChoosableInteger + 1)) / 2 < desiredTotal) return false;

    const memo = new Map();

    const canWin = (total, used) => {
        if (memo.has(used)) return memo.get(used);
        for (let i = 0; i < maxChoosableInteger; i++) {
            if (used & (1 << i)) continue;
            if (total + (i + 1) >= desiredTotal || !canWin(total + (i + 1), used | (1 << i))) {
                memo.set(used, true);
                return true;
            }
        }
        memo.set(used, false);
        return false;
    };

    return canWin(0, 0);
};