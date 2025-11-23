function maxScore(nums) {
    const n = nums.length;
    const memo = {};

    function gcd(a, b) {
        while (b) {
            const temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    function dfs(mask) {
        if (mask in memo) return memo[mask];
        const count = binCount(mask);
        if (count === n) return 0;
        let maxScore = 0;
        for (let i = 0; i < n; i++) {
            if ((mask & (1 << i)) === 0) {
                for (let j = i + 1; j < n; j++) {
                    if ((mask & (1 << j)) === 0) {
                        const newMask = mask | (1 << i) | (1 << j);
                        const score = Math.floor(gcd(nums[i], nums[j])) * (count + 1);
                        const remainingScore = dfs(newMask);
                        maxScore = Math.max(maxScore, score + remainingScore);
                    }
                }
            }
        }
        memo[mask] = maxScore;
        return maxScore;
    }

    function binCount(mask) {
        let count = 0;
        while (mask) {
            count += mask & 1;
            mask >>= 1;
        }
        return count;
    }

    return dfs(0);
}