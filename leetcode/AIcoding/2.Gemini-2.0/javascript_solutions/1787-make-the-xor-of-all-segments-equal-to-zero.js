var makeTheIntegerZero = function(nums, k) {
    const n = nums.length;
    const count = new Map();
    let ans = 0;

    for (let i = 0; i < k; i++) {
        count.clear();
        let maxCount = 0;
        let totalCount = 0;
        for (let j = i; j < n; j += k) {
            totalCount++;
            const num = nums[j];
            count.set(num, (count.get(num) || 0) + 1);
            maxCount = Math.max(maxCount, count.get(num));
        }
        ans += totalCount - maxCount;
    }

    return ans;
};