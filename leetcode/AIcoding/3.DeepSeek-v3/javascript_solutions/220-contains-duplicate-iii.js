var containsNearbyAlmostDuplicate = function(nums, k, t) {
    if (k < 1 || t < 0) return false;
    const map = new Map();
    const w = t + 1;
    for (let i = 0; i < nums.length; i++) {
        const id = Math.floor(nums[i] / w);
        if (map.has(id)) return true;
        if (map.has(id - 1) && Math.abs(nums[i] - map.get(id - 1)) <= t) return true;
        if (map.has(id + 1) && Math.abs(nums[i] - map.get(id + 1)) <= t) return true;
        map.set(id, nums[i]);
        if (i >= k) map.delete(Math.floor(nums[i - k] / w));
    }
    return false;
};