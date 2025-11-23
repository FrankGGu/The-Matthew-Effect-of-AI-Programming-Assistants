var minMoves = function(nums, k) {
    const ones = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) ones.push(i);
    }

    const m = ones.length;
    if (m < k) return -1;

    let minMoves = Infinity;
    const prefixSum = new Array(m + 1).fill(0);

    for (let i = 1; i <= m; i++) {
        prefixSum[i] = prefixSum[i - 1] + ones[i - 1];
    }

    for (let i = k - 1; i < m; i++) {
        const mid = i - k + 1;
        const total = ones[i] * (k) - (prefixSum[i + 1] - prefixSum[mid]);
        minMoves = Math.min(minMoves, total);
    }

    return minMoves;
};