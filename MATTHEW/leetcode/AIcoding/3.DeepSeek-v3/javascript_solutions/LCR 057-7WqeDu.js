var containsNearbyAlmostDuplicate = function(nums, k, t) {
    const getBucketId = (num, width) => {
        return Math.floor(num / width);
    };

    if (t < 0) return false;
    const map = new Map();
    const width = t + 1;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const bucketId = getBucketId(num, width);

        if (map.has(bucketId)) {
            return true;
        }
        if (map.has(bucketId - 1) && Math.abs(num - map.get(bucketId - 1)) <= t) {
            return true;
        }
        if (map.has(bucketId + 1) && Math.abs(num - map.get(bucketId + 1)) <= t) {
            return true;
        }

        map.set(bucketId, num);

        if (i >= k) {
            const oldNum = nums[i - k];
            const oldBucketId = getBucketId(oldNum, width);
            map.delete(oldBucketId);
        }
    }

    return false;
};