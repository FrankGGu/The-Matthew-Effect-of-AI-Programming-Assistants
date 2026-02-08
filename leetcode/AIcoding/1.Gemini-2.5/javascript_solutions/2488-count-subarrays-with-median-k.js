var countSubarrays = function(nums, k) {
    let k_idx = -1;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === k) {
            k_idx = i;
            break;
        }
    }

    let ans = 0;
    let balance = 0;
    let map = new Map(); // Stores frequencies of balance sums for the left part (ending before k_idx)

    // Populate map for prefix sums of subarrays ending at k_idx - 1
    // The balance for an empty prefix (before k_idx) is 0
    map.set(0, 1); 

    // Iterate from k_idx - 1 down to 0
    // Calculate balance for subarrays nums[i...k_idx-1]
    for (let i = k_idx - 1; i >= 0; i--) {
        if (nums[i] > k) {
            balance++;
        } else { // nums[i] < k
            balance--;
        }
        map.set(balance, (map.get(balance) || 0) + 1);
    }

    // Reset balance for the right part (starting from k_idx)
    balance = 0;
    // Iterate from k_idx up to nums.length - 1
    // Calculate balance for subarrays nums[k_idx...j]
    for (let j = k_idx; j < nums.length; j++) {
        if (nums[j] > k) {
            balance++;
        } else if (nums[j] < k) {
            balance--;
        }
        // Now 'balance' represents sum(transformed_arr[k_idx...j])
        // We are looking for subarrays nums[i...j] such that k is the median.
        // This means sum(transformed_arr[i...j]) should be 0 or -1.
        // sum(transformed_arr[i...j]) = sum(transformed_arr[i...k_idx-1]) + sum(transformed_arr[k_idx...j])
        // Let left_balance = sum(transformed_arr[i...k_idx-1])
        // So, left_balance + balance == 0  => left_balance == -balance
        // Or, left_balance + balance == -1 => left_balance == -1 - balance

        ans += (map.get(-balance) || 0);
        ans += (map.get(-1 - balance) || 0);
    }

    return ans;
};