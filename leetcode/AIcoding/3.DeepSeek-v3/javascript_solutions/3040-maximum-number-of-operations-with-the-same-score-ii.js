var maxOperations = function(nums) {
    const n = nums.length;
    const memo = {};

    const dfs = (start, end, target) => {
        if (start >= end) return 0;
        const key = `${start},${end},${target}`;
        if (memo[key] !== undefined) return memo[key];

        let res = 0;
        if (nums[start] + nums[start + 1] === target) {
            res = Math.max(res, 1 + dfs(start + 2, end, target));
        }
        if (nums[start] + nums[end] === target) {
            res = Math.max(res, 1 + dfs(start + 1, end - 1, target));
        }
        if (nums[end - 1] + nums[end] === target) {
            res = Math.max(res, 1 + dfs(start, end - 2, target));
        }
        memo[key] = res;
        return res;
    };

    const option1 = dfs(2, n - 1, nums[0] + nums[1]);
    const option2 = dfs(1, n - 2, nums[0] + nums[n - 1]);
    const option3 = dfs(0, n - 3, nums[n - 2] + nums[n - 1]);

    return 1 + Math.max(option1, option2, option3);
};