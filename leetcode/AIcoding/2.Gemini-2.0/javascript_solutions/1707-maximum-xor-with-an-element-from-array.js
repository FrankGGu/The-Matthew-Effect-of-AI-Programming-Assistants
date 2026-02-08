var maximizeXor = function(nums, queries) {
    nums.sort((a, b) => a - b);
    const result = [];

    for (const [x, m] of queries) {
        let max_xor = -1;
        let left = 0;
        let right = nums.length - 1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (nums[mid] <= m) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        for (let i = 0; i < left; i++) {
            max_xor = Math.max(max_xor, x ^ nums[i]);
        }

        result.push(max_xor);
    }

    return result;
};