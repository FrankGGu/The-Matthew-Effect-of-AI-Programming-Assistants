var numSubseq = function(nums, target) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    nums.sort((a, b) => a - b);
    const power = Array(n).fill(1);

    for (let i = 1; i < n; i++) {
        power[i] = (power[i - 1] * 2) % MOD;
    }

    let left = 0, right = n - 1, count = 0;

    while (left <= right) {
        if (nums[left] + nums[right] <= target) {
            count = (count + power[right - left]) % MOD;
            left++;
        } else {
            right--;
        }
    }

    return count;
};