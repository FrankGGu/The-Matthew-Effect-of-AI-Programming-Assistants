var peopleAwareOfSecret = function(n, delay, forget) {
    const dp = new Array(n + 1).fill(0);
    dp[1] = 1;
    let shared = 0;
    let mod = 10**9 + 7;

    for (let i = 2; i <= n; i++) {
        shared = 0;
        for (let j = 1; j < i; j++) {
            if (i - j >= delay && i - j < forget) {
                shared = (shared + dp[j]) % mod;
            }
        }
        dp[i] = shared;
    }

    let result = 0;
    for (let i = n - forget + 1; i <= n; i++) {
        result = (result + dp[i]) % mod;
    }

    return result;
};