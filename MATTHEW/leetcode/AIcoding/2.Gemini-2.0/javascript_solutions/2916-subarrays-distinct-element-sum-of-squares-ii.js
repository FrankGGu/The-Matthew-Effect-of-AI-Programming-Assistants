var sumCounts = function(nums) {
    const MOD = 10**9 + 7;
    let n = nums.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        let set = new Set();
        for (let j = i; j < n; j++) {
            set.add(nums[j]);
            ans = (ans + (set.size * set.size) % MOD) % MOD;
        }
    }
    return ans;
};