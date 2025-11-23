function maximumTotalReward(nums) {
    nums.sort((a, b) => a - b);
    const unique = [];
    for (let i = 0; i < nums.length; i++) {
        if (i === 0 || nums[i] !== nums[i - 1]) {
            unique.push(nums[i]);
        }
    }
    nums = unique;
    const dp = new Set();
    dp.add(0);
    for (const num of nums) {
        const temp = new Set(dp);
        for (const val of dp) {
            if (val + num > val) {
                temp.add(val + num);
            }
        }
        dp.clear();
        for (const val of temp) {
            dp.add(val);
        }
    }
    return Math.max(...dp);
}