var shortestSubarrayWithOR = function(nums, k) {
    let minLen = Infinity;
    let or_sums_at_prev_right = new Map();

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        let or_sums_at_current_right = new Map();

        or_sums_at_current_right.set(num, right);
        if (num >= k) {
            minLen = Math.min(minLen, 1);
        }

        for (const [prev_or_val, prev_start_idx] of or_sums_at_prev_right.entries()) {
            const current_or_val = prev_or_val | num;
            const current_start_idx = prev_start_idx;

            if (or_sums_at_current_right.has(current_or_val)) {
                or_sums_at_current_right.set(current_or_val, Math.min(or_sums_at_current_right.get(current_or_val), current_start_idx));
            } else {
                or_sums_at_current_right.set(current_or_val, current_start_idx);
            }

            if (current_or_val >= k) {
                minLen = Math.min(minLen, right - current_start_idx + 1);
            }
        }

        or_sums_at_prev_right = or_sums_at_current_right;
    }

    return minLen === Infinity ? -1 : minLen;
};