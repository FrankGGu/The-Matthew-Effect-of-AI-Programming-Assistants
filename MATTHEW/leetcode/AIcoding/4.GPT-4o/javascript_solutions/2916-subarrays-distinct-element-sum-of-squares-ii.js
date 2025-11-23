var distinctElementSumOfSquares = function(nums) {
    const n = nums.length;
    const mod = 1e9 + 7;
    let result = 0;
    let lastSeen = new Map();
    let sum = 0;

    for (let i = 0; i < n; i++) {
        if (lastSeen.has(nums[i])) {
            let index = lastSeen.get(nums[i]);
            sum = (sum - (nums[index] ** 2)) % mod;
        }
        sum = (sum + (nums[i] ** 2)) % mod;
        lastSeen.set(nums[i], i);
        result = (result + sum) % mod;
    }

    return result;
};