var containsNearbyAlmostDuplicate = function(nums, k, t) {
    if (k < 1 || t < 0) return false;
    const map = new Map();
    for (let i = 0; i < nums.length; i++) {
        const remappedNum = nums[i] - Number.MIN_SAFE_INTEGER;
        const bucket = Math.floor(remappedNum / (t + 1));
        if (map.has(bucket) || (map.has(bucket - 1) && Math.abs(nums[i] - map.get(bucket - 1)) <= t) || (map.has(bucket + 1) && Math.abs(nums[i] - map.get(bucket + 1)) <= t)) {
            return true;
        }
        map.set(bucket, nums[i]);
        if (i >= k) {
            const lastRemappedNum = nums[i - k] - Number.MIN_SAFE_INTEGER;
            const lastBucket = Math.floor(lastRemappedNum / (t + 1));
            map.delete(lastBucket);
        }
    }
    return false;
};