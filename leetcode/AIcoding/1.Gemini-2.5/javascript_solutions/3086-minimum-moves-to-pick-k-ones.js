var minMoves = function(nums, k) {
    const pos = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            pos.push(i);
        }
    }

    const nOnes = pos.length;

    const A = new Array(nOnes);
    for (let j = 0; j < nOnes; j++) {
        A[j] = pos[j] - j;
    }

    const prefixSumA = new Array(nOnes);
    prefixSumA[0] = A[0];
    for (let j = 1; j < nOnes; j++) {
        prefixSumA[j] = prefixSumA[j-1] + A[j];
    }

    let minCost = Infinity;

    for (let i = 0; i <= nOnes - k; i++) {
        if (pos[i+k-1] - pos[i] > 2 * k - 1) {
            continue;
        }

        const medianIdx = i + Math.floor((k - 1) / 2);
        const medianVal = A[medianIdx];

        const leftCount = medianIdx - i + 1;
        const sumLeft = prefixSumA[medianIdx] - (i > 0 ? prefixSumA[i-1] : 0);

        const rightCount = (i + k - 1) - medianIdx;
        const sumRight = prefixSumA[i+k-1] - prefixSumA[medianIdx];

        const currentCost = (leftCount * medianVal - sumLeft) + (sumRight - rightCount * medianVal);
        minCost = Math.min(minCost, currentCost);
    }

    return minCost;
};