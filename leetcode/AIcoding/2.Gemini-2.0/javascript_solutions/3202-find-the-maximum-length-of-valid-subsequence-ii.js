var findMaximumLength = function(nums, k) {
    nums.sort((a, b) => a - b);
    let dp = new Map();
    let sum = 0;
    let ans = 0;

    for (let num of nums) {
        let len = 1;
        if (dp.has(num)) {
            len = dp.get(num) + 1;
        }
        ans = Math.max(ans, len);
        let next = num + k;
        let val = len;
        if (dp.has(next)) {
            val = Math.max(val, dp.get(next));
        }
        dp.set(next, val);
    }

    return ans;
};