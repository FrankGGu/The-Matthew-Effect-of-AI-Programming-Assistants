var maxNonOverlapping = function(nums, target) {
    let count = 0;
    let sum = 0;
    const seen = new Set([0]);
    for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
        if (seen.has(sum - target)) {
            count++;
            sum = 0;
            seen.clear();
            seen.add(0);
        } else {
            seen.add(sum);
        }
    }
    return count;
};