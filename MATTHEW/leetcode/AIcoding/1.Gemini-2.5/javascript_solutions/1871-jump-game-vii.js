var canReach = function(s, minJump, maxJump) {
    const n = s.length;
    const dp = new Array(n).fill(false);
    const prefixSum = new Array(n).fill(0);

    dp[0] = true;
    prefixSum[0] = 1;

    for (let j = 1; j < n; j++) {
        if (s[j] === '1') {
            prefixSum[j] = prefixSum[j - 1];
            continue;
        }

        const leftBound = j - maxJump;
        const rightBound = j - minJump;

        let numReachableInWindow = 0;

        if (rightBound >= 0) {
            numReachableInWindow = prefixSum[rightBound];
            if (leftBound > 0) {
                numReachableInWindow -= prefixSum[leftBound - 1];
            }
        }

        if (numReachableInWindow > 0) {
            dp[j] = true;
        }

        prefixSum[j] = prefixSum[j - 1] + (dp[j] ? 1 : 0);
    }

    return dp[n - 1];
};