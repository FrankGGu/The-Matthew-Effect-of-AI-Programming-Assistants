function canReach(s, minJump, maxJump) {
    const n = s.length;
    const dp = new Array(n).fill(false);
    dp[0] = true;
    let prev = 0;
    for (let i = 1; i < n; i++) {
        if (i - minJump >= 0) {
            prev += dp[i - minJump];
        }
        if (i - maxJump > 0) {
            prev -= dp[i - maxJump - 1];
        }
        if (prev > 0 && s[i] === '0') {
            dp[i] = true;
        }
    }
    return dp[n - 1];
}