var countFairPairs = function(nums, lower, upper) {
    nums.sort((a, b) => a - b);
    let count = 0;

    const countPairs = (target) => {
        let left = 0, right = nums.length - 1, pairs = 0;
        while (left < right) {
            const sum = nums[left] + nums[right];
            if (sum < target) {
                left++;
            } else {
                pairs += right - left;
                right--;
            }
        }
        return pairs;
    };

    count += countPairs(upper + 1) - countPairs(lower);
    return count;
};