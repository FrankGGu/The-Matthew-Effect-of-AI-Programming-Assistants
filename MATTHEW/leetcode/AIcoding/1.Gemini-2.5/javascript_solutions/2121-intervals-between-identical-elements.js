var getDistances = function(arr) {
    const n = arr.length;
    const ans = new Array(n).fill(0);
    const valToIndices = new Map();

    for (let i = 0; i < n; i++) {
        const val = arr[i];
        if (!valToIndices.has(val)) {
            valToIndices.set(val, []);
        }
        valToIndices.get(val).push(i);
    }

    for (const [val, indices] of valToIndices.entries()) {
        const k = indices.length;
        if (k <= 1) {
            continue;
        }

        const prefixSum = new Array(k + 1).fill(0);
        for (let i = 0; i < k; i++) {
            prefixSum[i + 1] = prefixSum[i] + indices[i];
        }

        const totalSum = prefixSum[k];

        for (let m = 0; m < k; m++) {
            const currentIdx = indices[m];

            const sumLeft = prefixSum[m];
            const countLeft = m;

            const sumRight = totalSum - prefixSum[m + 1];
            const countRight = k - 1 - m;

            ans[currentIdx] = (countLeft * currentIdx - sumLeft) + (sumRight - countRight * currentIdx);
        }
    }

    return ans;
};