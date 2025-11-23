var canIWin = function(maxChoosableInteger, desiredTotal) {
    if (desiredTotal <= 0) return true;
    if ((1 + maxChoosableInteger) * maxChoosableInteger / 2 < desiredTotal) return false;

    const memo = new Map();
    const nums = Array.from({ length: maxChoosableInteger }, (_, i) => i + 1);

    function canWin(nums, desiredTotal) {
        const key = nums.join(',');
        if (memo.has(key)) return memo.get(key);

        if (nums.length === 0) return false;

        for (let i = 0; i < nums.length; i++) {
            if (nums[i] >= desiredTotal) {
                memo.set(key, true);
                return true;
            }

            const nextNums = [...nums.slice(0, i), ...nums.slice(i + 1)];
            if (!canWin(nextNums, desiredTotal - nums[i])) {
                memo.set(key, true);
                return true;
            }
        }

        memo.set(key, false);
        return false;
    }

    return canWin(nums, desiredTotal);
};