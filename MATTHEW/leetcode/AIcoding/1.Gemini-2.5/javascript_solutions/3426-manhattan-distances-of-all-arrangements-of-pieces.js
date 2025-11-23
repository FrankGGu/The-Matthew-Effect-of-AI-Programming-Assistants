var sumManhattanDistances = function(pieces, rooks) {
    const k = pieces.length;
    const MOD = 1_000_000_007n; // Use BigInt for modulo operations

    // Helper function to calculate sum_{i=0}^{k-1} sum_{j=0}^{k-1} |arr1[i] - arr2[j]| modulo MOD.
    // Both arr1 and arr2 are assumed to be sorted before calling this function.
    const calculateSumAbsDiff = (arr1, arr2) => {
        if (k === 0) return 0n;

        // Create prefix sums for arr2. These sums can be large, so store them as BigInts.
        // prefix_sum_arr2[p] stores the sum of arr2[0]...arr2[p-1].
        const prefix_sum_arr2 = new Array(k + 1).fill(0n);
        for (let i = 0; i < k; i++) {
            prefix_sum_arr2[i+1] = prefix_sum_arr2[i] + BigInt(arr2[i]);
        }

        let total_diff_sum = 0n;

        for (let i = 0; i < k; i++) {
            const x_i = BigInt(arr1[i]);

            // Binary search to find the count of elements in arr2 that are less than or equal to x_i.
            // p_plus_1 will be the number of elements in arr2 that are <= x_i.
            // It's also the index of the first element in arr2 strictly greater than x_i.
            // If all elements in arr2 are <= x_i, p_plus_1 will be k.
            let low = 0, high = k;
            let p_plus_1 = k; 
            while (low < high) {
                let mid = Math.floor((low + high) / 2);
                if (BigInt(arr2[mid]) > x_i) {
                    p_plus_1 = mid;
                    high = mid;
                } else {
                    low = mid + 1;
                }
            }

            // The contribution of x_i to the total sum is:
            // sum_{j=0}^{p_plus_1-1} (x_i - arr2[j]) + sum_{j=p_plus_1}^{k-1} (arr2[j] - x_i)
            // This simplifies to:
            // (p_plus_1 * x_i - prefix_sum_arr2[p_plus_1]) + ((prefix_sum_arr2[k] - prefix_sum_arr2[p_plus_1]) - (k - p_plus_1) * x_i)
            // = (2 * p_plus_1 - k) * x_i - 2 * prefix_sum_arr2[p_plus_1] + prefix_sum_arr2[k]

            let term1 = (BigInt(2 * p_plus_1) - BigInt(k)) * x_i;
            let term2 = BigInt(2) * prefix_sum_arr2[p_plus_1];
            let term3 = prefix_sum_arr2[k];

            let current_diff = (term1 - term2 + term3);

            current_diff %= MOD;
            if (current_diff < 0n) { // Ensure the result is positive for modulo
                current_diff += MOD;
            }

            total_diff_sum = (total_diff_sum + current_diff) % MOD;
        }
        return total_diff_sum;
    };

    // Extract row and column coordinates from initial pieces and target rooks
    const r_coords = pieces.map(p => p[0]);
    const c_coords = pieces.map(p => p[1]);
    const r_prime_coords = rooks.map(p => p[0]);
    const c_prime_coords = rooks.map(p => p[1]);

    // Sort all coordinate arrays for efficient calculation in calculateSumAbsDiff
    r_coords.sort((a, b) => a - b);
    c_coords.sort((a, b) => a - b);
    r_prime_coords.sort((a, b) => a - b);
    c_prime_coords.sort((a, b) => a - b);

    // Calculate sum of absolute differences for row coordinates
    const sum_r = calculateSumAbsDiff(r_coords, r_prime_coords);
    // Calculate sum of absolute differences for column coordinates
    const sum_c = calculateSumAbsDiff(c_coords, c_prime_coords);

    // Calculate (k-1)! modulo MOD
    let factorial_k_minus_1 = 1n;
    for (let i = 1; i < k; i++) {
        factorial_k_minus_1 = (factorial_k_minus_1 * BigInt(i)) % MOD;
    }

    // The total sum is (k-1)! * (sum_{i,j}|r_i - r'_j| + sum_{i,j}|c_i - c'_j|) % MOD
    const total_sum_rc = (sum_r + sum_c) % MOD;
    const result = (factorial_k_minus_1 * total_sum_rc) % MOD;

    // Convert the BigInt result back to a Number as required by LeetCode
    return Number(result);
};