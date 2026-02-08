var countDistinct = function(nums, k, p) {
    const n = nums.length;
    const distinctSubarrays = new Set();

    for (let i = 0; i < n; i++) {
        let divisibleCount = 0;
        for (let j = i; j < n; j++) {
            if (nums[j] % p === 0) {
                divisibleCount++;
            }

            if (divisibleCount <= k) {
                distinctSubarrays.add(JSON.stringify(nums.slice(i, j + 1)));
            } else {
                break;
            }
        }
    }

    return distinctSubarrays.size;
};