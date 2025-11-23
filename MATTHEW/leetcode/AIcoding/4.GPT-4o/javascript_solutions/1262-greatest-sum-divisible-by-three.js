var maxSumDivThree = function(nums) {
    let dp = [0, 0, 0];
    for (let num of nums) {
        let temp = dp.slice();
        for (let i = 0; i < 3; i++) {
            temp[(i + num) % 3] = Math.max(temp[(i + num) % 3], dp[i] + num);
        }
        dp = temp;
    }
    return dp[0];
};