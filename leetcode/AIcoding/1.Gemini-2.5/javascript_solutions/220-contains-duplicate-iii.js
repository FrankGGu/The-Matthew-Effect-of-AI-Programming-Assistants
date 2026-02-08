var containsNearbyAlmostDuplicate = function(nums, k, t) {
    if (t < 0 || k < 0) {
        return false;
    }

    const buckets = new Map();
    const W = t + 1; // Bucket width. Ensures numbers in the same bucket satisfy abs(x-y) <= t.

    for (let i = 0; i < nums.length; i++) {
        // Remove element that falls out of the sliding window.
        // The window for indices j (where j < i) is [i - k, i - 1].
        // So, when processing nums[i], the element nums[i - k - 1] (if it exists) should be removed.
        if (i > k) { 
            const prevNum = nums[i - k - 1]; 
            const prevId = Math.floor(prevNum / W);
            buckets.delete(prevId);
        }

        const num = nums[i];
        const id = Math.floor(num / W); // Calculate bucket ID for the current number

        // Check the current bucket.
        // If a number already exists in this bucket, it means abs(num - stored_num_in_bucket) < W,
        // which implies abs(num - stored_num_in_bucket) <= t.
        // The index difference condition is handled by the sliding window.
        if (buckets.has(id)) {
            return true;
        }

        // Check adjacent buckets (id - 1 and id + 1).
        // A number in an adjacent bucket might also satisfy the value difference condition.
        if (buckets.has(id - 1) && Math.abs(num - buckets.get(id - 1)) <= t) {
            return true;
        }
        if (buckets.has(id + 1) && Math.abs(num - buckets.get(id + 1)) <= t) {
            return true;
        }

        // Add the current number to its bucket.
        // We store the number itself, not just a boolean, to check value difference with adjacent buckets.
        buckets.set(id, num);
    }

    return false;
};