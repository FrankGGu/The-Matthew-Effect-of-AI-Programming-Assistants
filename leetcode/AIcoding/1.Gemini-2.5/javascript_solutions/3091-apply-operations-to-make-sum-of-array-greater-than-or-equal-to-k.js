var minOperations = function(k) {
    if (k === 1) {
        return 0;
    }

    let minOps = k - 1; // Initialize with the strategy: increment '1' to 'k' (k-1 operations), then 0 duplicates.

    // We want to find an optimal value 'x' to create from the initial '1'.
    // To get 'x' from '1', it takes 'x - 1' increment operations.
    // Once we have 'x', we need to duplicate it to reach a total sum of at least 'k'.
    // The number of copies of 'x' needed is Math.ceil(k / x).
    // To get Math.ceil(k / x) copies, it takes Math.ceil(k / x) - 1 duplicate operations.
    // Total operations for a given 'x' = (x - 1) + (Math.ceil(k / x) - 1).

    // The function (x - 1) + (k/x - 1) is minimized when x is close to sqrt(k).
    // Therefore, we only need to iterate 'x' up to Math.sqrt(k).
    // If the optimal 'x' is greater than sqrt(k), then k/x would be less than sqrt(k),
    // and the symmetric case (where 'x' is replaced by 'k/x' approximately) would have been covered.
    for (let x = 1; x * x <= k; x++) {
        let currentOps = (x - 1) + (Math.ceil(k / x) - 1);
        minOps = Math.min(minOps, currentOps);
    }

    return minOps;
};