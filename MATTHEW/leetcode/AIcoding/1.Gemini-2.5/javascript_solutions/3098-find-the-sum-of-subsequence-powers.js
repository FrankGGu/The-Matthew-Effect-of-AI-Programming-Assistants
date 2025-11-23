var sumOfPower = function(nums, k, p) {
    const MOD = 10**9 + 7;
    const n = nums.length;

    nums.sort((a, b) => a - b);

    const power = (base, exp) => {
        let res = 1;
        base %= MOD;
        if (base === 0) return 0; 
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp = Math.floor(exp / 2);
        }
        return res;
    };

    const countAtLeast = (threshold) => {
        const dp = Array(n).fill(0).map(() => Array(k + 1).fill(0));

        for (let i = 0; i < n; i++) {
            dp[i][1] = 1;
        }

        for (let j = 2; j <= k; j++) {
            let sum_prev_dp = 0;
            let prev_idx_ptr = 0;

            for (let i = 0; i < n; i++) {
                while (prev_idx_ptr < i && nums[prev_idx_ptr] <= nums[i] - threshold) {
                    sum_prev_dp = (sum_prev_dp + dp[prev_idx_ptr][j - 1]) % MOD;
                    prev_idx_ptr++;
                }
                dp[i][j] = sum_prev_dp;
            }
        }

        let total_count = 0;
        for (let i = 0; i < n; i++) {
            total_count = (total_count + dp[i][k]) % MOD;
        }
        return total_count;
    };

    const diffs = new Set();
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const diff = nums[j] - nums[i];
            if (diff > 0) {
                diffs.add(diff);
            }
        }
    }
    const sorted_diffs = Array.from(diffs).sort((a, b) => a - b);

    let total_sum_of_powers = 0;
    let prev_count = 0;

    for (let i = sorted_diffs.length - 1; i >= 0; i--) {
        const current_d = sorted_diffs[i];

        const current_count = countAtLeast(current_d);

        let count_exactly_d = (current_count - prev_count + MOD) % MOD;

        if (count_exactly_d > 0) {
            const power_val = power(current_d, p);
            total_sum_of_powers = (total_sum_of_powers + (count_exactly_d * power_val) % MOD) % MOD;
        }
        prev_count = current_count;
    }

    return total_sum_of_powers;
};