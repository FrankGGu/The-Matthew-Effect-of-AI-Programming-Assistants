function sumOfGoodSubsequences(nums) {
    const mod = 1e9 + 7;
    let totalSum = 0;
    let currentSum = 0;
    let count = 1;

    nums.sort((a, b) => a - b);

    for (let i = 0; i < nums.length; i++) {
        currentSum = (currentSum * 2 + nums[i] * count) % mod;
        totalSum = (totalSum + currentSum) % mod;
        count = (count * 2) % mod;
    }

    return totalSum;
}