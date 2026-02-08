var minimizeOr = function(nums, k) {
    const n = nums.length;

    // Helper function to check if a given target_OR is achievable
    // It returns true if we can partition the array into at least (n - k) segments
    // such that the bitwise AND of elements within each segment is a submask of target_OR.
    const check = (target_OR) => {
        let segments_formed = 0;
        // Initialize current_and with all bits set (e.g., (1 << 30) - 1 or -1 in 32-bit signed int)
        // This ensures that the first element `nums[i]` correctly initializes `current_and`
        // when `current_and &= nums[i]` is performed.
        let current_and_value = (1 << 30) - 1; 

        for (let i = 0; i < n; i++) {
            current_and_value &= nums[i];
            // If the bitwise AND of the current segment's elements (`current_and_value`)
            // is a submask of `target_OR`, it means this segment is valid.
            // We can choose to end the current segment here.
            // By ending it as early as possible, we maximize the number of segments formed.
            if ((current_and_value | target_OR) === target_OR) {
                segments_formed++;
                // Reset `current_and_value` to start a new segment
                current_and_value = (1 << 30) - 1; 
            }
        }

        // The problem requires us to be left with `n - k` elements.
        // If we can form `segments_formed` valid segments (each being a submask of `target_OR`),
        // and `segments_formed` is greater than or equal to `n - k`, then it's possible.
        // We can always merge some of these `segments_formed` valid segments to reduce their count to `n - k`.
        // Merging segments (performing more AND operations) can only make their value smaller or equal,
        // thus maintaining the property that their AND-sum is a submask of `target_OR`.
        return segments_formed >= (n - k);
    };

    // The possible range for the minimum OR sum is from 0 to (1 << 30) - 1.
    // (1 << 30) - 1 is a safe upper bound as nums[i] are up to 10^9.
    let low = 0;
    let high = (1 << 30) - 1; 
    let ans = high; // Initialize answer with the highest possible value

    // Perform binary search on the answer
    while (low <= high) {
        const mid = low + Math.floor((high - low) / 2);
        if (check(mid)) {
            // If `mid` is achievable, it could be our answer or we might find a smaller one.
            ans = mid;
            high = mid - 1; // Try to find a smaller `target_OR`
        } else {
            // If `mid` is not achievable, we need a larger `target_OR`.
            low = mid + 1;
        }
    }

    return ans;
};