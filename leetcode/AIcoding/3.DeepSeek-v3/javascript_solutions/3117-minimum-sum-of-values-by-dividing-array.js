var minSum = function(nums, andValues) {
    const n = nums.length;
    const m = andValues.length;
    const memo = new Map();

    function dp(i, j, currentAnd) {
        if (j === m) return i === n ? 0 : Infinity;
        if (i === n) return Infinity;

        const key = `${i},${j},${currentAnd}`;
        if (memo.has(key)) return memo.get(key);

        const newAnd = currentAnd & nums[i];
        let res = dp(i + 1, j, newAnd);

        if (newAnd === andValues[j]) {
            const next = dp(i + 1, j + 1, ~0);
            if (next !== Infinity) {
                res = Math.min(res, nums[i] + next);
            }
        }

        memo.set(key, res);
        return res;
    }

    const result = dp(0, 0, ~0);
    return result === Infinity ? -1 : result;
};