var tupleSameProduct = function(nums) {
    const n = nums.length;
    const prodCounts = new Map();

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const product = nums[i] * nums[j];
            prodCounts.set(product, (prodCounts.get(product) || 0) + 1);
        }
    }

    let totalTuples = 0;
    for (const count of prodCounts.values()) {
        if (count >= 2) {
            // If there are 'count' pairs that result in the same product,
            // we need to choose 2 distinct pairs from these 'count' pairs.
            // The number of ways to choose 2 pairs is C(count, 2) = count * (count - 1) / 2.
            // Since all numbers in nums are distinct, choosing two distinct pairs (a,b) and (c,d)
            // with a*b = c*d guarantees that a, b, c, d are all distinct.
            // For each such combination of two pairs, say (a,b) and (c,d),
            // we can form 8 tuples:
            // (a,b,c,d), (a,b,d,c), (b,a,c,d), (b,a,d,c),
            // (c,d,a,b), (c,d,b,a), (d,c,a,b), (d,c,b,a)
            totalTuples += (count * (count - 1) / 2) * 8;
        }
    }

    return totalTuples;
};