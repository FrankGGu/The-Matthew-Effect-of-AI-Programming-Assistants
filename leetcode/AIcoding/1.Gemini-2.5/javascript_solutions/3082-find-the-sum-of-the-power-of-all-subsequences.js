var sumOfPower = function(nums, k) {
    const MOD = 10**9 + 7;
    const N = nums.length;

    // Modular exponentiation function
    function power(base, exp) {
        let res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    }

    // Handle k=0 case separately
    if (k === 0) {
        // If k is 0, only subsequences where max - min = 0 contribute 1.
        // This means all elements in the subsequence must be identical.
        // We need to count such subsequences.
        let total = 0;
        nums.sort((a, b) => a - b); // Sort to group identical numbers

        let count = 0;
        for (let i = 0; i < N; i++) {
            count++;
            if (i === N - 1 || nums[i] !== nums[i+1]) {
                // End of a block of identical numbers
                // For a block of 'count' identical numbers, there are (2^count - 1) non-empty subsequences.
                total = (total + power(2, count) - 1 + MOD) % MOD; // Add (2^count - 1)
                count = 0; // Reset count for the next block
            }
        }
        return total;
    }

    nums.sort((a, b) => a - b);

    // Modular inverse of 2 and k
    const inv2 = power(2, MOD - 2);
    const invK = power(k, MOD - 2);

    // Initialize total_sum with contributions from single-element subsequences (k^0 = 1 for each).
    // There are N such subsequences.
    let total_sum = N; 

    // prefix_sum_val stores sum_{j=0}^{i-1} (invK^(nums[j]) * inv2^j) % MOD
    let prefix_sum_val = 0; 

    for (let i = 0; i < N; i++) {
        if (i > 0) {
            // Contribution from subsequences where nums[i] is the maximum and nums[j] (j < i) is the minimum.
            // The formula derived is:
            // sum_{j=0}^{i-1} (k^(nums[i] - nums[j]) * 2^(i - j - 1))
            // = k^(nums[i]) * 2^(i-1) * sum_{j=0}^{i-1} (invK^(nums[j]) * inv2^j)

            const pow_k_nums_i = power(k, nums[i]);
            const pow_2_i_minus_1 = power(2, i - 1);

            const term_i_contribution_factor = (pow_k_nums_i * pow_2_i_minus_1) % MOD;
            const current_contribution = (term_i_contribution_factor * prefix_sum_val) % MOD;

            total_sum = (total_sum + current_contribution) % MOD;
        }

        // Update prefix_sum_val for the next iteration by adding the term for current i:
        // (invK^(nums[i]) * inv2^i)
        const invK_nums_i = power(invK, nums[i]);
        const inv2_i = power(inv2, i);
        const current_term_for_prefix = (invK_nums_i * inv2_i) % MOD;

        prefix_sum_val = (prefix_sum_val + current_term_for_prefix) % MOD;
    }

    return total_sum;
};