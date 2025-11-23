var maxScore = function(nums) {
    const n = nums.length / 2;
    const memo = new Array(1 << nums.length).fill(-1);

    function dfs(mask, step) {
        if (step === n + 1) return 0;
        if (memo[mask] !== -1) return memo[mask];

        let max = 0;
        for (let i = 0; i < nums.length; i++) {
            if ((mask & (1 << i)) continue;
            for (let j = i + 1; j < nums.length; j++) {
                if ((mask & (1 << j))) continue;
                const newMask = mask | (1 << i) | (1 << j);
                const currentScore = step * gcd(nums[i], nums[j]);
                const totalScore = currentScore + dfs(newMask, step + 1);
                max = Math.max(max, totalScore);
            }
        }
        memo[mask] = max;
        return max;
    }

    return dfs(0, 1);
};

function gcd(a, b) {
    if (b === 0) return a;
    return gcd(b, a % b);
}