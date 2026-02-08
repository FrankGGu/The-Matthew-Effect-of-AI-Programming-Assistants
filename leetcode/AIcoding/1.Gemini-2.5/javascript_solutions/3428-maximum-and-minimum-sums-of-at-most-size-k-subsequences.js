var numSubseq = function(nums, target) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const MOD = 10 ** 9 + 7;

    const powers = new Array(n);
    powers[0] = 1;
    for (let i = 1; i < n; i++) {
        powers[i] = (powers[i - 1] * 2) % MOD;
    }

    let count = 0;
    let left = 0;
    let right = n - 1;

    while (left <= right) {
        if (nums[left] + nums[right] <= target) {
            count = (count + powers[right - left]) % MOD;
            left++;
        } else {
            right--;
        }
    }

    return count;
};