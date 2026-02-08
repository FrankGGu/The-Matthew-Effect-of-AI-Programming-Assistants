var repeatedNTimes = function(nums) {
    const n = nums.length / 2;
    const counts = {};
    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
        if (counts[num] === n) {
            return num;
        }
    }
};