var numSubseq = function(nums, target) {
    const MOD = 1e9 + 7;
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const pow = new Array(n + 1);
    pow[0] = 1;
    for (let i = 1; i <= n; i++) {
        pow[i] = (pow[i - 1] * 2) % MOD;
    }

    let left = 0;
    let right = n - 1;
    let res = 0;

    while (left <= right) {
        if (nums[left] + nums[right] > target) {
            right--;
        } else {
            res = (res + pow[right - left]) % MOD;
            left++;
        }
    }

    return res;
};