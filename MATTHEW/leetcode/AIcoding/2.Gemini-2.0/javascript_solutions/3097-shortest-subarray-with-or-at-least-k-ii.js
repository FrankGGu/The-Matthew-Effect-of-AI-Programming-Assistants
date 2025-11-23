var shortestSubarray = function(nums, k) {
    let n = nums.length;
    let ans = Infinity;
    for (let i = 0; i < n; i++) {
        let curr = 0;
        for (let j = i; j < n; j++) {
            curr |= nums[j];
            if (curr >= k) {
                ans = Math.min(ans, j - i + 1);
                break;
            }
        }
    }
    return ans === Infinity ? -1 : ans;
};