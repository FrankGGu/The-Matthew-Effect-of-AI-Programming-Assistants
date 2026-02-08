var subarraysWithKDistinct = function(nums, k) {
    function atMostK(nums, k) {
        let left = 0;
        let right = 0;
        let count = 0;
        let map = new Map();

        while (right < nums.length) {
            if (!map.has(nums[right]) || map.get(nums[right]) === 0) {
                k--;
            }
            map.set(nums[right], (map.get(nums[right]) || 0) + 1);

            while (k < 0) {
                map.set(nums[left], map.get(nums[left]) - 1);
                if (map.get(nums[left]) === 0) {
                    k++;
                }
                left++;
            }

            count += right - left + 1;
            right++;
        }

        return count;
    }

    return atMostK(nums, k) - atMostK(nums, k - 1);
};