var minCost = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= i; j++) {
            const subArray = nums.slice(i - j, i);
            const cost = k + getCost(subArray);
            dp[i] = Math.min(dp[i], dp[i - j] + cost);
        }
    }

    return dp[n];

    function getCost(subArray) {
        const counts = {};
        let redundancy = 0;
        for (const num of subArray) {
            counts[num] = (counts[num] || 0) + 1;
            if (counts[num] > 1) {
                redundancy++;
            }
        }
        return redundancy;
    }
};