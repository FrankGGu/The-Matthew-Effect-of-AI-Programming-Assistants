var countSubarrays = function(nums, k) {
    let count = 0;
    const n = nums.length;
    const freq = new Map();

    for (let i = 0; i < n; i++) {
        freq.clear();
        let maxCount = 0;
        for (let j = i; j < n; j++) {
            freq.set(nums[j], (freq.get(nums[j]) || 0) + 1);
            maxCount = Math.max(maxCount, freq.get(nums[j]));
            if (maxCount >= k) {
                count++;
            }
        }
    }

    return count;
};