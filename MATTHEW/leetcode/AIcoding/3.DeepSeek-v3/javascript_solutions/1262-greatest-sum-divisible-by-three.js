var maxSumDivThree = function(nums) {
    let dp = [0, -Infinity, -Infinity];
    for (let num of nums) {
        let next = [...dp];
        for (let i = 0; i < 3; i++) {
            let sum = dp[i] + num;
            let mod = sum % 3;
            next[mod] = Math.max(next[mod], sum);
        }
        dp = next;
    }
    return dp[0];
};