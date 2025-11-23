var minChanges = function(nums, k) {
    const n = nums.length;
    const freq = Array.from({ length: k }, () => new Map());
    for (let i = 0; i < n; i++) {
        const pos = i % k;
        freq[pos].set(nums[i], (freq[pos].get(nums[i]) || 0) + 1);
    }

    let dp = new Array(1024).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < k; i++) {
        const size = Math.floor((n - 1 - i) / k) + 1;
        const minPrev = Math.min(...dp);
        const newDp = new Array(1024).fill(minPrev + size);

        for (let x = 0; x < 1024; x++) {
            if (dp[x] === Infinity) continue;
            for (const [num, cnt] of freq[i]) {
                const newX = x ^ num;
                newDp[newX] = Math.min(newDp[newX], dp[x] + size - cnt);
            }
        }
        dp = newDp;
    }

    return dp[0];
};