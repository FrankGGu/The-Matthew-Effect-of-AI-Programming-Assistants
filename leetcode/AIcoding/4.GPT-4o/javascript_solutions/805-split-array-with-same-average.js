var splitArraySameAverage = function(A) {
    const n = A.length;
    const totalSum = A.reduce((a, b) => a + b, 0);
    const possibleSums = new Set();

    for (let size = 1; size <= n / 2; size++) {
        if (totalSum * size % n === 0) {
            const targetSum = (totalSum * size) / n;
            const dp = new Set([0]);

            for (let num of A) {
                for (let s of Array.from(dp).reverse()) {
                    dp.add(s + num);
                }
            }
            if (dp.has(targetSum)) return true;
        }
    }
    return false;
};