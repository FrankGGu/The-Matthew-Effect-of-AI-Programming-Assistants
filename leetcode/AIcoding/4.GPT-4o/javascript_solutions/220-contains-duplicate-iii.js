var containsNearbyAlmostDuplicate = function(nums, k, t) {
    if (k <= 0 || t < 0) return false;
    let map = new Map();

    for (let i = 0; i < nums.length; i++) {
        let bucket = Math.floor(nums[i] / (t + 1));
        if (map.has(bucket) ||
            (map.has(bucket - 1) && nums[i] - map.get(bucket - 1) <= t) ||
            (map.has(bucket + 1) && map.get(bucket + 1) - nums[i] <= t))) {
            return true;
        }
        map.set(bucket, nums[i]);
        if (i >= k) {
            map.delete(Math.floor(nums[i - k] / (t + 1)));
        }
    }
    return false;
};