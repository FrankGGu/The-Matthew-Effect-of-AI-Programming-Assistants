var numSubarraysWithSum = function(nums, goal) {
    let sum = 0;
    let count = 0;
    const map = new Map();
    map.set(0, 1);

    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        const diff = sum - goal;
        if (map.has(diff)) {
            count += map.get(diff);
        }
        map.set(sum, (map.get(sum) || 0) + 1);
    }

    return count;
};