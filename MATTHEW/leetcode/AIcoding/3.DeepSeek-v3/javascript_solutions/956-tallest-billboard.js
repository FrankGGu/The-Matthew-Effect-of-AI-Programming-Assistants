var tallestBillboard = function(rods) {
    let dp = {0: 0};
    for (let rod of rods) {
        let curr = {...dp};
        for (let key in curr) {
            let diff = parseInt(key);
            let sum = curr[key];
            let newDiff = diff + rod;
            let newSum = sum + rod;
            dp[newDiff] = Math.max(dp[newDiff] || 0, newSum);
            newDiff = Math.abs(diff - rod);
            newSum = Math.max(sum, sum - diff + rod);
            dp[newDiff] = Math.max(dp[newDiff] || 0, newSum);
        }
    }
    return dp[0] || 0;
};