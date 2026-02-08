function recoverArray(n, sums) {
    const total = sums.reduce((a, b) => a + b) / 2;
    const sumsSet = new Set(sums);

    function backtrack(target, k) {
        if (k === 0) return target === 0 ? [] : null;
        for (let sum of sumsSet) {
            const nextTarget = target - sum;
            if (sumsSet.has(nextTarget)) {
                sumsSet.delete(sum);
                sumsSet.delete(nextTarget);
                const result = backtrack(nextTarget, k - 1);
                if (result !== null) {
                    return [sum, ...result];
                }
                sumsSet.add(nextTarget);
                sumsSet.add(sum);
            }
        }
        return null;
    }

    return backtrack(total, n) || [];
}