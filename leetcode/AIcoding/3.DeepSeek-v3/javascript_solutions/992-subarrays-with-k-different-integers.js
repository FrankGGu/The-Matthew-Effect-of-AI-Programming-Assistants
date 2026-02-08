var subarraysWithKDistinct = function(nums, k) {
    const atMostK = (k) => {
        let left = 0, res = 0;
        const count = {};
        let distinct = 0;
        for (let right = 0; right < nums.length; right++) {
            if (!count[nums[right]]) {
                distinct++;
                count[nums[right]] = 0;
            }
            count[nums[right]]++;
            while (distinct > k) {
                count[nums[left]]--;
                if (count[nums[left]] === 0) {
                    distinct--;
                }
                left++;
            }
            res += right - left + 1;
        }
        return res;
    };
    return atMostK(k) - atMostK(k - 1);
};