var numberOfGoodSubarraySplits = function(nums) {
    const MOD = 1e9 + 7;
    let ones = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === 1) {
            ones.push(i);
        }
    }
    if (ones.length === 0) {
        return 0;
    }
    let res = 1;
    for (let i = 1; i < ones.length; i++) {
        let diff = ones[i] - ones[i - 1];
        res = (res * diff) % MOD;
    }
    return res;
};