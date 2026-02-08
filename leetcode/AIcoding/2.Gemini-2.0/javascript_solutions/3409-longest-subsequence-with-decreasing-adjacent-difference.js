var longestSubsequence = function(nums) {
    const n = nums.length;
    const dp = new Map();

    function solve(index, prev) {
        if (index === n) {
            return 0;
        }

        const key = `${index}-${prev}`;
        if (dp.has(key)) {
            return dp.get(key);
        }

        let ans = solve(index + 1, prev);

        if (prev === -1 || nums[index] < nums[prev]) {
            ans = Math.max(ans, 1 + solve(index + 1, index));
        }

        dp.set(key, ans);
        return ans;
    }

    return solve(0, -1);
};