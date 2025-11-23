var minMoves = function(nums, k) {
    const ones = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            ones.push(i);
        }
    }

    if (k === 1) return 0;

    const prefixSum = new Array(ones.length + 1).fill(0);
    for (let i = 0; i < ones.length; i++) {
        prefixSum[i + 1] = prefixSum[i] + ones[i];
    }

    let median = Math.floor(k / 2);
    let ans = Infinity;
    let windowSum = 0;

    for (let i = 0; i <= ones.length - k; i++) {
        let curMedian = ones[i + median];
        let left = i;
        let right = i + k - 1;

        let sum = prefixSum[right + 1] - prefixSum[left];
        let medianIndex = i + median;
        let moves = sum - prefixSum[medianIndex + 1] + prefixSum[left] - curMedian * (k - median);
        moves += curMedian * median - (prefixSum[medianIndex] - prefixSum[left]);

        let offset = 0;
        for(let j = 0; j < k; j++){
            offset += Math.abs(j - median);
        }
        ans = Math.min(ans, moves - offset);
    }

    return ans;
};