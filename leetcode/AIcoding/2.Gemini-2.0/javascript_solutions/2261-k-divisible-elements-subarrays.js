var countDistinct = function(nums, k, p) {
    const n = nums.length;
    const subarrays = new Set();

    for (let i = 0; i < n; i++) {
        let count = 0;
        let subarray = [];
        for (let j = i; j < n; j++) {
            if (nums[j] % p === 0) {
                count++;
            }

            if (count > k) {
                break;
            }

            subarray.push(nums[j]);
            subarrays.add(subarray.join(','));
        }
    }

    return subarrays.size;
};