var minChanges = function(nums, k) {
    let n = nums.length;
    let ans = 0;
    for (let i = 0; i < k; i++) {
        let counts = {};
        let total = 0;
        for (let j = i; j < n; j += k) {
            total++;
            if (counts[nums[j]] === undefined) {
                counts[nums[j]] = 0;
            }
            counts[nums[j]]++;
        }
        let maxCount = 0;
        for (let num in counts) {
            maxCount = Math.max(maxCount, counts[num]);
        }
        ans += (total - maxCount);
    }
    return ans;
};