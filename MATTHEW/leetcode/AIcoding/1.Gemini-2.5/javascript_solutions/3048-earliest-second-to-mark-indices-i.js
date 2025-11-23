var earliestSecondToMarkIndices = function(nums, changeOperations) {
    const n = nums.length;
    const m = changeOperations.length;

    let ans = -1;

    // Helper function to check if it's possible to mark all indices by time `t_check`
    const can = (t_check) => {
        // We need at least n seconds to mark n indices (1 second per mark operation).
        if (t_check < n) {
            return false;
        }

        let time_spent_on_decreases = 0;
        let time_spent_on_change_ops = 0;

        // Find the latest available change operation for each index within t_check.
        // This array stores the latest 'op_time' for an index 'i' such that op_time <= t_check.
        // If no such operation exists, it remains -1.
        const latest_op_time_for_idx = new Array(n).fill(-1);
        for (let j = 0; j < m; j++) {
            const [idx, op_time] = changeOperations[j];
            // Only consider operations whose event time is within the current `t_check`
            if (op_time <= t_check) {
                latest_op_time_for_idx[idx] = Math.max(latest_op_time_for_idx[idx], op_time);
            }
        }

        // For each index, decide the most efficient way to make nums[i] zero
        // and sum up the "preparation" costs.
        for (let i = 0; i < n; i++) {
            if (nums[i] === 0) {
                // If nums[i] is already 0, no preparation time is needed.
                // It just needs 1 second for the 'mark' operation itself.
            } else if (latest_op_time_for_idx[i] !== -1) {
                // If a change operation is available for index 'i' by time t_check,
                // we can choose to "perform" it. This costs 1 second.
                time_spent_on_change_ops++;
            } else {
                // If nums[i] is not 0 and no change operation is available by t_check,
                // we must decrease nums[i] value to 0. This costs nums[i] seconds.
                time_spent_on_decreases += nums[i];
            }
        }

        // Total time required is the sum of:
        // 1. Time spent decreasing values.
        // 2. Time spent performing change operations.
        // 3. Time spent marking all n indices (n seconds, as each mark takes 1 second).
        const total_time_required = time_spent_on_decreases + time_spent_on_change_ops + n;

        // Check if the total required time is within the allowed `t_check`.
        return total_time_required <= t_check;
    };

    // Binary search for the earliest second.
    // The minimum possible time is 'n' (if all nums[i] are 0 and no prep needed).
    // The maximum possible time can be 'n + sum(nums[i])' (if all nums[i] are decreased)
    // or '2*n' (if all indices use change operations).
    // Given nums[i] up to 10^9 and n up to 10^5, sum(nums[i]) can be 10^14.
    // A safe upper bound for 'high' is around 2 * 10^14.
    let low = n;
    let high = 2 * 10**14; // Sufficiently large upper bound

    while (low <= high) {
        const mid = Math.floor(low + (high - low) / 2);
        if (can(mid)) {
            ans = mid;
            high = mid - 1; // Try to find an even earlier time
        } else {
            low = mid + 1; // Need more time
        }
    }

    return ans;
};