var maxSum = function(nums, k) {
    let ones = 0;
    for (let num of nums) {
        if (num === 1) {
            ones++;
        }
    }

    let zeros = nums.length - ones;

    let ans = 0;
    const mod = 10**9 + 7;

    for (let i = 0; i < k; i++) {
        if (ones > 0) {
            ans = (ans + 1) % mod;
            ones--;
        } else {
            zeros--;
        }
        ans = (ans * 2) % mod;
    }

    return ans;
};