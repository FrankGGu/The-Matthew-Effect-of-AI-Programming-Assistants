var sumOfDistances = function(nums) {
    const n = nums.length;
    const ans = new Array(n).fill(0);
    const valToIndices = new Map();

    for (let i = 0; i < n; i++) {
        if (!valToIndices.has(nums[i])) {
            valToIndices.set(nums[i], []);
        }
        valToIndices.get(nums[i]).push(i);
    }

    for (const indices of valToIndices.values()) {
        if (indices.length <= 1) {
            continue;
        }

        const m = indices.length;
        let totalSumIndices = 0;
        for (const idx of indices) {
            totalSumIndices += idx;
        }

        let currentSumLeft = 0;
        let countLeft = 0;
        let currentSumRight = totalSumIndices;
        let countRight = m;

        for (let j = 0; j < m; j++) {
            const idx_j = indices[j];

            currentSumRight -= idx_j;
            countRight -= 1;

            const sumLeft = (countLeft * idx_j) - currentSumLeft;
            const sumRight = currentSumRight - (countRight * idx_j);

            ans[idx_j] = sumLeft + sumRight;

            currentSumLeft += idx_j;
            countLeft += 1;
        }
    }

    return ans;
};