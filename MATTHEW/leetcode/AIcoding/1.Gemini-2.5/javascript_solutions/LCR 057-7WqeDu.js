var containsNearbyAlmostDuplicate = function(nums, k, t) {
    if (t < 0 || k < 0) {
        return false;
    }
    if (k === 0) {
        return false; // abs(i - j) <= 0 implies i === j, but indices must be distinct
    }

    const buckets = new Map();
    // The size of each bucket. If t=0, bucketSize=1. If t=1, bucketSize=2.
    // Numbers x and y are in the same bucket if Math.floor(x / bucketSize) === Math.floor(y / bucketSize).
    // If they are in the same bucket, then abs(x - y) <= bucketSize - 1 = t.
    const bucketSize = t + 1;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];

        // Calculate the bucket ID for the current number.
        // Math.floor(num / bucketSize) correctly partitions numbers into buckets
        // for both positive and negative values.
        const id = Math.floor(num / bucketSize);

        // Check the current bucket.
        // If there's already a number in this bucket, then abs(num - existing_num) <= t is guaranteed.
        if (buckets.has(id)) {
            return true;
        }

        // Check the left adjacent bucket (id - 1).
        // If there's a number `prevNum` in `id - 1` bucket, check if abs(num - prevNum) <= t.
        // Since `num` is in a higher bucket than `prevNum`, `num >= prevNum`, so we check `num - prevNum <= t`.
        if (buckets.has(id - 1)) {
            const prevNum = buckets.get(id - 1);
            if (num - prevNum <= t) {
                return true;
            }
        }

        // Check the right adjacent bucket (id + 1).
        // If there's a number `nextNum` in `id + 1` bucket, check if abs(num - nextNum) <= t.
        // Since `nextNum` is in a higher bucket than `num`, `nextNum >= num`, so we check `nextNum - num <= t`.
        if (buckets.has(id + 1)) {
            const nextNum = buckets.get(id + 1);
            if (nextNum - num <= t) {
                return true;
            }
        }

        // Add the current number to its bucket.
        buckets.set(id, num);

        // If the window size exceeds k, remove the element that is k positions behind.
        if (i >= k) {
            const oldNum = nums[i - k];
            const oldId = Math.floor(oldNum / bucketSize);
            buckets.delete(oldId);
        }
    }

    return false;
};