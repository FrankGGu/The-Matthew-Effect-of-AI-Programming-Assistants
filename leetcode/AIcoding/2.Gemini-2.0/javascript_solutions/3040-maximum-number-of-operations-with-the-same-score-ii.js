var maxOperations = function(nums) {
    const n = nums.length;
    const memo = new Map();

    function solve(left, right, target) {
        if (left >= right) {
            return 0;
        }

        const key = `${left}-${right}-${target}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        let ans = 0;

        if (nums[left] + nums[left + 1] === target) {
            ans = Math.max(ans, 1 + solve(left + 2, right, target));
        }

        if (nums[right] + nums[right - 1] === target) {
            ans = Math.max(ans, 1 + solve(left, right - 2, target));
        }

        if (nums[left] + nums[right] === target) {
            ans = Math.max(ans, 1 + solve(left + 1, right - 1, target));
        }

        memo.set(key, ans);
        return ans;
    }

    let ans = 0;
    ans = Math.max(ans, solve(0, n - 1, nums[0] + nums[1]));
    ans = Math.max(ans, solve(0, n - 1, nums[0] + nums[n - 1]));
    ans = Math.max(ans, solve(0, n - 1, nums[n - 2] + nums[n - 1]));

    return ans;
};