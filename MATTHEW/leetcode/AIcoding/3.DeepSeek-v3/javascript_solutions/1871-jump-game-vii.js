var canReach = function(s, minJump, maxJump) {
    const n = s.length;
    if (s[n - 1] !== '0') return false;
    const dp = new Array(n).fill(false);
    dp[0] = true;
    let pre = 0;

    for (let i = 1; i < n; i++) {
        if (i >= minJump && dp[i - minJump]) {
            pre++;
        }
        if (i > maxJump && dp[i - maxJump - 1]) {
            pre--;
        }
        dp[i] = pre > 0 && s[i] === '0';
    }

    return dp[n - 1];
};