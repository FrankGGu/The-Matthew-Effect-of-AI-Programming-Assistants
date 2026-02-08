var minimumTime = function(nums1, nums2, x) {
    const n = nums1.length;
    const indices = Array.from({ length: n }, (_, i) => i);
    indices.sort((a, b) => nums2[a] - nums2[b]);

    const sortedNums1 = indices.map(i => nums1[i]);
    const sortedNums2 = indices.map(i => nums2[i]);

    let totalSum = nums1.reduce((sum, num) => sum + num, 0);

    for (let i = 0; i < n; i++) {
        totalSum += nums2[i];
    }

    let dp = new Array(n + 1).fill(0).map(() => new Array(n + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= i; j++) {
            if (j === 0) {
                dp[i][j] = dp[i - 1][j];
            } else {
                dp[i][j] = Math.min(dp[i - 1][j], dp[i - 1][j - 1] + sortedNums1[i - 1] + sortedNums2[i - 1] * i);
            }
        }
    }

    for (let t = 0; t <= n; t++) {
        let sum = 0;
        for(let i = 0; i < n; i++){
            sum += nums2[i];
        }
        if (totalSum + t * sum - dp[n][t] <= x) {
            return t;
        }
    }

    return -1;
};