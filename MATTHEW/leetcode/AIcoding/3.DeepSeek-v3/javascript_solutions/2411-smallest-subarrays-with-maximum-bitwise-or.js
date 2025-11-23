var smallestSubarrays = function(nums) {
    const n = nums.length;
    const result = new Array(n).fill(1);
    const last = new Array(32).fill(-1);

    for (let i = n - 1; i >= 0; i--) {
        for (let j = 0; j < 32; j++) {
            if (nums[i] & (1 << j)) {
                last[j] = i;
            }
        }
        let maxLast = i;
        for (let j = 0; j < 32; j++) {
            if (last[j] !== -1) {
                maxLast = Math.max(maxLast, last[j]);
            }
        }
        result[i] = maxLast - i + 1;
    }

    return result;
};