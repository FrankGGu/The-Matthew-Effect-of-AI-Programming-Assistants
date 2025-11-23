function containsNearbyDuplicate(nums, k, t, m) {
    if (t === 0) return false;
    const map = {};
    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const bucket = Math.floor(num / t);
        if (map[bucket] !== undefined) return true;
        if (map[bucket - 1] !== undefined && Math.abs(num - map[bucket - 1]) <= t) return true;
        if (map[bucket + 1] !== undefined && Math.abs(num - map[bucket + 1]) <= t) return true;
        map[bucket] = num;
        if (i >= m) delete map[Math.floor(nums[i - m] / t)];
    }
    return false;
}