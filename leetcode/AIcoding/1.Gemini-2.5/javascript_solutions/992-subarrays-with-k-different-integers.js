var subarraysWithKDistinct = function(nums, k) {
    const countAtMost = (kVal) => {
        if (kVal < 0) {
            return 0;
        }

        let left = 0;
        let ans = 0;
        const map = new Map();
        let distinctCount = 0;

        for (let right = 0; right < nums.length; right++) {
            const numR = nums[right];
            map.set(numR, (map.get(numR) || 0) + 1);
            if (map.get(numR) === 1) {
                distinctCount++;
            }

            while (distinctCount > kVal) {
                const numL = nums[left];
                map.set(numL, map.get(numL) - 1);
                if (map.get(numL) === 0) {
                    distinctCount--;
                }
                left++;
            }
            ans += (right - left + 1);
        }
        return ans;
    };

    return countAtMost(k) - countAtMost(k - 1);
};