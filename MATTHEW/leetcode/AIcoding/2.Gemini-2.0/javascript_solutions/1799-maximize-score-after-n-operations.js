var maxScore = function(nums) {
    const n = nums.length / 2;
    const memo = new Map();

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    function solve(mask, op) {
        if (op > n) {
            return 0;
        }

        if (memo.has(mask)) {
            return memo.get(mask);
        }

        let maxScore = 0;
        for (let i = 0; i < 2 * n; i++) {
            if ((mask & (1 << i)) === 0) {
                for (let j = i + 1; j < 2 * n; j++) {
                    if ((mask & (1 << j)) === 0) {
                        const newMask = mask | (1 << i) | (1 << j);
                        maxScore = Math.max(maxScore, op * gcd(nums[i], nums[j]) + solve(newMask, op + 1));
                    }
                }
                break;
            }
        }

        memo.set(mask, maxScore);
        return maxScore;
    }

    return solve(0, 1);
};