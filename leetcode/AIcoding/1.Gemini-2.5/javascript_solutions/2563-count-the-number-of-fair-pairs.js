var countFairPairs = function(nums, lower, upper) {
    nums.sort((a, b) => a - b);

    function countPairsLessThanOrEqual(target) {
        let count = 0;
        let n = nums.length;
        let right = n - 1;
        for (let left = 0; left < n; left++) {
            while (right > left && nums[left] + nums[right] > target) {
                right--;
            }
            if (right <= left) {
                break;
            }
            count += (right - left);
        }
        return count;
    }

    return countPairsLessThanOrEqual(upper) - countPairsLessThanOrEqual(lower - 1);
};