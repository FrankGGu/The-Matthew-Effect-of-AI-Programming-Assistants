var majorityElement = function(nums) {
    const n = nums.length;
    const threshold = Math.floor(n / 3);
    const counts = {};
    const result = [];

    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
    }

    for (const num in counts) {
        if (counts[num] > threshold) {
            result.push(parseInt(num));
        }
    }

    return result;
};