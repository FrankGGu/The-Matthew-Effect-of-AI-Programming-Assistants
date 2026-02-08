var subsequencesWithRawUniqueMiddleMode = function(nums, k) {
    const MOD = 10**9 + 7;
    const n = nums.length;
    let ans = 0;

    for (let i = 0; i < n; i++) {
        if (nums[i] !== k) {
            continue;
        }

        // Calculate dp_left for elements nums[0...i-1]
        // dp_left[balance_offset] stores the number of subsequences from nums[0...i-1]
        // where balance = (count of k's) - (count of non-k's)
        // The actual balance ranges from -i to i. We offset it by i to map to [0, 2*i].
        const leftMaxBalance = i;
        let dpLeft = new Array(2 * leftMaxBalance + 1).fill(0);
        dpLeft[leftMaxBalance] = 1; // Represents an empty subsequence, balance 0

        for (let j = 0; j < i; j++) {
            const num = nums[j];
            const newDpLeft = new Array(2 * leftMaxBalance + 1).fill(0);
            for (let balIdx = 0; balIdx <= 2 * leftMaxBalance; balIdx++) {
                if (dpLeft[balIdx] === 0) continue;

                // Option 1: Don't include nums[j] in the subsequence
                newDpLeft[balIdx] = (newDpLeft[balIdx] + dpLeft[balIdx]) % MOD;

                // Option 2: Include nums[j] in the subsequence
                if (num === k) {
                    // If nums[j] is k, balance increases by 1
                    if (balIdx + 1 <= 2 * leftMaxBalance) {
                        newDpLeft[balIdx + 1] = (newDpLeft[balIdx + 1] + dpLeft[balIdx]) % MOD;
                    }
                } else {
                    // If nums[j] is not k, balance decreases by 1
                    if (balIdx - 1 >= 0) {
                        newDpLeft[balIdx - 1] = (newDpLeft[balIdx - 1] + dpLeft[balIdx]) % MOD;
                    }
                }
            }
            dpLeft = newDpLeft;
        }

        // Calculate dp_right for elements nums[i+1...n-1]
        // Similar logic as dp_left
        const rightLen = n - 1 - i;
        const rightMaxBalance = rightLen;
        let dpRight = new Array(2 * rightMaxBalance + 1).fill(0);
        dpRight[rightMaxBalance] = 1; // Represents an empty subsequence, balance 0

        for (let j = i + 1; j < n; j++) {
            const num = nums[j];
            const newDpRight = new Array(2 * rightMaxBalance + 1).fill(0);
            for (let balIdx = 0; balIdx <= 2 * rightMaxBalance; balIdx++) {
                if (dpRight[balIdx] === 0) continue;

                // Option 1: Don't include nums[j]
                newDpRight[balIdx] = (newDpRight[balIdx] + dpRight[balIdx]) % MOD;

                // Option 2: Include nums[j]
                if (num === k) {
                    // If nums[j] is k, balance increases by 1
                    if (balIdx + 1 <= 2 * rightMaxBalance) {
                        newDpRight[balIdx + 1] = (newDpRight[balIdx + 1] + dpRight[balIdx]) % MOD;
                    }
                } else {
                    // If nums[j] is not k, balance decreases by 1
                    if (balIdx - 1 >= 0) {
                        newDpRight[balIdx - 1] = (newDpRight[balIdx - 1] + dpRight[balIdx]) % MOD;
                    }
                }
            }
            dpRight = newDpRight;
        }

        // Combine left and right subsequences
        // The middle element nums[i] is k, so it adds 1 to k's count and 0 to non-k's count.
        // Total balance = (left_subsequence_balance) + (right_subsequence_balance) + 1.
        // We need total_balance > 0 for k to be the unique mode.
        // This is because if count(k) > sum(count(x) for x != k), then for any specific x != k,
        // count(k) > sum(count(x) for x != k) >= count(x), which implies count(k) > count(x).
        for (let balIdxL = 0; balIdxL <= 2 * leftMaxBalance; balIdxL++) {
            if (dpLeft[balIdxL] === 0) continue;
            const leftBalance = balIdxL - leftMaxBalance;

            for (let balIdxR = 0; balIdxR <= 2 * rightMaxBalance; balIdxR++) {
                if (dpRight[balIdxR] === 0) continue;
                const rightBalance = balIdxR - rightMaxBalance;

                if (leftBalance + rightBalance + 1 > 0) {
                    ans = (ans + dpLeft[balIdxL] * dpRight[balIdxR]) % MOD;
                }
            }
        }
    }

    return ans;
};