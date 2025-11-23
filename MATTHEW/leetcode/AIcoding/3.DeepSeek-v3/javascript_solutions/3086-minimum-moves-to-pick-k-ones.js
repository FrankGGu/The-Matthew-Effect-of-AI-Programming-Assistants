var minMoves = function(nums, k) {
    const ones = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            ones.push(i);
        }
    }

    const n = ones.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + ones[i];
    }

    let minMoves = Infinity;
    const radius = Math.floor(k / 2);

    for (let i = 0; i <= n - k; i++) {
        const j = i + k - 1;
        const mid = i + radius;
        const leftSum = prefixSum[mid] - prefixSum[i];
        const rightSum = prefixSum[j + 1] - prefixSum[mid + 1];
        const cost = rightSum - leftSum;

        if (k % 2 === 0) {
            minMoves = Math.min(minMoves, cost - ones[mid]);
        } else {
            minMoves = Math.min(minMoves, cost);
        }
    }

    return minMoves;
};