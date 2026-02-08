var minimumIncompatibility = function(A, K) {
    const n = A.length;
    const targetSize = n / K;
    let minCost = Infinity;
    const subsets = new Set();

    function backtrack(start, currentK, currentSet) {
        if (currentK === K) {
            if (currentSet.size === targetSize) {
                let cost = 0;
                for (let num of currentSet) {
                    cost |= (1 << num);
                }
                minCost = Math.min(minCost, cost);
            }
            return;
        }

        for (let i = start; i < n; i++) {
            if (!currentSet.has(A[i])) {
                currentSet.add(A[i]);
                backtrack(i + 1, currentK + (currentSet.size === targetSize ? 1 : 0), currentSet);
                currentSet.delete(A[i]);
            }
        }
    }

    backtrack(0, 0, new Set());
    return minCost === Infinity ? -1 : minCost;
};