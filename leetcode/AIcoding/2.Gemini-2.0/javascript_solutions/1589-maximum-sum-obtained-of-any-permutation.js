var maxSumRangeQuery = function(nums, requests) {
    const n = nums.length;
    const diff = new Array(n).fill(0);

    for (const [start, end] of requests) {
        diff[start]++;
        if (end + 1 < n) {
            diff[end + 1]--;
        }
    }

    const freq = new Array(n).fill(0);
    freq[0] = diff[0];
    for (let i = 1; i < n; i++) {
        freq[i] = freq[i - 1] + diff[i];
    }

    freq.sort((a, b) => a - b);
    nums.sort((a, b) => a - b);

    let maxSum = 0;
    for (let i = 0; i < n; i++) {
        maxSum = (maxSum + (freq[i] * nums[i])) % (10**9 + 7);
    }

    return maxSum;
};