var maxSumRangeQuery = function(nums, requests) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    const count = new Array(n + 1).fill(0);

    for (const [start, end] of requests) {
        count[start]++;
        if (end + 1 < n) {
            count[end + 1]--;
        }
    }

    for (let i = 1; i <= n; i++) {
        count[i] += count[i - 1];
    }

    count.pop();
    count.sort((a, b) => b - a);
    nums.sort((a, b) => b - a);

    let sum = 0;
    for (let i = 0; i < n; i++) {
        sum = (sum + nums[i] * count[i]) % MOD;
    }

    return sum;
};