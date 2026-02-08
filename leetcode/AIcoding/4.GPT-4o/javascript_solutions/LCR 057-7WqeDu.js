var containsNearbyAlmostDuplicate = function(nums, indexDiff, valueDiff) {
    const set = new Set();
    for (let i = 0; i < nums.length; i++) {
        if (i > indexDiff) {
            set.delete(nums[i - indexDiff - 1]);
        }
        for (let num of set) {
            if (Math.abs(num - nums[i]) <= valueDiff) {
                return true;
            }
        }
        set.add(nums[i]);
    }
    return false;
};