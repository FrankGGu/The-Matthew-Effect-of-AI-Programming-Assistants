var minMoves = function(nums, k) {
    if (k === 1) return 0;

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

    let res = Infinity;
    const radius = Math.floor((k - 1) / 2);

    for (let left = 0; left + k <= n; left++) {
        const right = left + k - 1;
        const mid = left + radius;
        const cost = ones[mid] * (2 * radius - k + 1) + 
                     (prefixSum[right + 1] - prefixSum[mid + 1]) - 
                     (prefixSum[mid] - prefixSum[left]);
        res = Math.min(res, cost);
    }

    return res;
};