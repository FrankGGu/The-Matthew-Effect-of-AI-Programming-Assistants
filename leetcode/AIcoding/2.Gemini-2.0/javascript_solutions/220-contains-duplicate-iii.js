var containsNearbyAlmostDuplicate = function(nums, k, t) {
    if (k < 1 || t < 0) return false;
    const map = new Map();
    for (let i = 0; i < nums.length; i++) {
        const remappedNum = nums[i];
        const bucket = Math.floor(remappedNum / (t + 1));
        if (map.has(bucket)) return true;
        if (map.has(bucket - 1) && Math.abs(remappedNum - map.get(bucket - 1)) <= t) return true;
        if (map.has(bucket + 1) && Math.abs(remappedNum - map.get(bucket + 1)) <= t) return true;
        map.set(bucket, remappedNum);
        if (i >= k) {
            const lastBucket = Math.floor(nums[i - k] / (t + 1));
            map.delete(lastBucket);
        }
    }
    return false;
};