var maxSumRangeQuery = function(nums, requests) {
    const n = nums.length;
    const freqCounts = new Array(n).fill(0);

    for (const [start, end] of requests) {
        freqCounts[start]++;
        if (end + 1 < n) {
            freqCounts[end + 1]--;
        }
    }

    for (let i = 1; i < n; i++) {
        freqCounts[i] += freqCounts[i - 1];
    }

    nums.sort((a, b) => a - b);
    freqCounts.sort((a, b) => a - b);

    let totalSum = 0;
    const MOD = 10**9 + 7;

    for (let i = 0; i < n; i++) {
        totalSum = (totalSum + (freqCounts[i] * nums[i])) % MOD;
    }

    return totalSum;
};