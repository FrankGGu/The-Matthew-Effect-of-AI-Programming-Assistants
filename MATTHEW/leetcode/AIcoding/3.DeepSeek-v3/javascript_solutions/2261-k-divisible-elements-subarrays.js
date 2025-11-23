var countDistinct = function(nums, k, p) {
    const n = nums.length;
    const set = new Set();

    for (let i = 0; i < n; i++) {
        let count = 0;
        let sub = '';
        for (let j = i; j < n; j++) {
            if (nums[j] % p === 0) {
                count++;
            }
            if (count > k) {
                break;
            }
            sub += nums[j] + ',';
            set.add(sub);
        }
    }

    return set.size;
};