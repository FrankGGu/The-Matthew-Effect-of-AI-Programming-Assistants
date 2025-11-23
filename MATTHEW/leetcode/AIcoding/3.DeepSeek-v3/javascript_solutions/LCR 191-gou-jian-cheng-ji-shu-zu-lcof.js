var statistics = function(nums) {
    const n = nums.length;
    const ans = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (i !== j && nums[j] < nums[i]) {
                count++;
            }
        }
        ans[i] = count;
    }
    return ans;
};