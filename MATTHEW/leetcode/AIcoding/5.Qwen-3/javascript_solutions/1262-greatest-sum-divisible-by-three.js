function maxSumDivThree(nums) {
    let dp = [0, -Infinity, -Infinity];
    for (let num of nums) {
        let temp = [...dp];
        for (let i = 0; i < 3; i++) {
            if (dp[i] !== -Infinity) {
                let remainder = (dp[i] + num) % 3;
                temp[remainder] = Math.max(temp[remainder], dp[i] + num);
            }
        }
        dp = temp;
    }
    return dp[0] === -Infinity ? 0 : dp[0];
}