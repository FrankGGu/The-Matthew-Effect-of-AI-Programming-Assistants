var numFactoredBinaryTrees = function(arr) {
    arr.sort((a, b) => a - b);
    const MOD = 10 ** 9 + 7;
    const dp = new Map();
    let totalTrees = 0;

    for (let i = 0; i < arr.length; i++) {
        const currentNum = arr[i];
        dp.set(currentNum, 1); // Initialize currentNum as a leaf node tree

        for (let j = 0; j < i; j++) {
            const leftFactor = arr[j];
            if (currentNum % leftFactor === 0) {
                const rightFactor = currentNum / leftFactor;
                if (dp.has(rightFactor)) {
                    // The number of ways to form currentNum as root with leftFactor and rightFactor as children
                    // is dp[leftFactor] * dp[rightFactor].
                    // The loop iterates through all smaller elements arr[j] as leftFactor.
                    // If leftFactor * rightFactor = currentNum, and leftFactor != rightFactor,
                    // this pair (leftFactor, rightFactor) will be counted when arr[j] is leftFactor,
                    // and the pair (rightFactor, leftFactor) will be counted when arr[j] is rightFactor (if rightFactor is also in arr and smaller than currentNum).
                    // This correctly accounts for ordered children (left child, right child).
                    let ways = (dp.get(leftFactor) * dp.get(rightFactor)) % MOD;
                    dp.set(currentNum, (dp.get(currentNum) + ways) % MOD);
                }
            }
        }
        totalTrees = (totalTrees + dp.get(currentNum)) % MOD;
    }

    return totalTrees;
};