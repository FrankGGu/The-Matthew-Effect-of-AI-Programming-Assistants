var sumDistance = function(nums, s, d) {
    const n = nums.length;
    const pos = new Array(n);
    for (let i = 0; i < n; i++) {
        if (s[i] === 'L') {
            pos[i] = nums[i] - d;
        } else {
            pos[i] = nums[i] + d;
        }
    }

    pos.sort((a, b) => a - b);

    let ans = 0;
    let prefixSum = 0;
    const MOD = 10**9 + 7;

    for (let i = 0; i < n; i++) {
        ans = (ans + (pos[i] * i - prefixSum) % MOD + MOD) % MOD;
        prefixSum = (prefixSum + pos[i]) % MOD;
    }

    return ans;
};