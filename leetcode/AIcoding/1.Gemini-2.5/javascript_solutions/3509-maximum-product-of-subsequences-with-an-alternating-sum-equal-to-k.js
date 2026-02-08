var maxProductSubsequencesWithAlternatingSum = function(nums, k) {
    // dp state: Map<sum, Map<last_op, [max_product, min_product]>>
    // last_op: 0 for adding the last element, 1 for subtracting the last element
    // We track both max_product and min_product because multiplying by a negative number flips the sign,
    // so a minimum negative product can become a maximum positive product.
    let dp = new Map(); // Stores current valid subsequences
    let ans = -Infinity; // Initialize with negative infinity for maximum product

    // Helper function to update product arrays in the dp map
    const updateProducts = (targetMap, sum, op, newMaxProd, newMinProd) => {
        if (!targetMap.has(sum)) {
            targetMap.set(sum, new Map());
        }
        if (!targetMap.get(sum).has(op)) {
            targetMap.get(sum).set(op, [-Infinity, Infinity]); // Initialize with sentinel values
        }
        const currentProds = targetMap.get(sum).get(op);
        currentProds[0] = Math.max(currentProds[0], newMaxProd);
        currentProds[1] = Math.min(currentProds[1], newMinProd);
    };

    for (const num of nums) {
        const next_dp = new Map();

        // Step 1: Copy states from dp to next_dp.
        // These represent subsequences that do not include the current 'num'.
        // This ensures that subsequences formed before 'num' are carried forward.
        for (const [prev_sum, op_map] of dp.entries()) {
            for (const [prev_op, prods] of op_map.entries()) {
                updateProducts(next_dp, prev_sum, prev_op, prods[0], prods[1]);
            }
        }

        // Step 2: Start a new subsequence with the current 'num'.
        // The first element of any subsequence is considered "added" (positive).
        updateProducts(next_dp, num, 0, num, num);

        // Step 3: Extend existing subsequences from dp using the current 'num'.
        for (const [prev_sum, op_map] of dp.entries()) {
            for (const [prev_op, [max_prev_prod, min_prev_prod]] of op_map.entries()) {
                // Skip invalid previous states
                if (max_prev_prod === -Infinity && min_prev_prod === Infinity) {
                    continue;
                }

                let current_sum;
                let current_op;
                let prod1, prod2;

                if (prev_op === 0) { // If the previous element was added, the current one must be subtracted.
                    current_sum = prev_sum - num;
                    current_op = 1; // Represents subtracting
                } else { // If the previous element was subtracted, the current one must be added.
                    current_sum = prev_sum + num;
                    current_op = 0; // Represents adding
                }

                // Calculate the new maximum and minimum products.
                // We need to consider both max_prev_prod * num and min_prev_prod * num,
                // as 'num' can be negative, potentially flipping which product is max/min.
                prod1 = max_prev_prod * num;
                prod2 = min_prev_prod * num;

                const current_max_prod = Math.max(prod1, prod2);
                const current_min_prod = Math.min(prod1, prod2);

                updateProducts(next_dp, current_sum, current_op, current_max_prod, current_min_prod);
            }
        }
        dp = next_dp; // Update dp for the next iteration
    }

    // After processing all numbers, check for subsequences with alternating sum equal to k.
    if (dp.has(k)) {
        const op_map = dp.get(k);
        for (const [op, [max_prod, min_prod]] of op_map.entries()) {
            ans = Math.max(ans, max_prod);
        }
    }

    // If no subsequence with sum 'k' was found, 'ans' will still be -Infinity.
    // In such cases, it's common to return -1 (or 0 if 0 is a valid default for no solution).
    // Assuming -1 is the expected return for no valid subsequence.
    return ans === -Infinity ? -1 : ans;
};