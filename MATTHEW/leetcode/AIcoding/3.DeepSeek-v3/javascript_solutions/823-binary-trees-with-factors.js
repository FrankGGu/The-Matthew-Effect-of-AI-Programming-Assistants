var numFactoredBinaryTrees = function(arr) {
    const MOD = 1e9 + 7;
    arr.sort((a, b) => a - b);
    const dp = {};
    for (let num of arr) {
        dp[num] = 1;
    }
    for (let i = 0; i < arr.length; i++) {
        for (let j = 0; j < i; j++) {
            if (arr[i] % arr[j] === 0) {
                const quotient = arr[i] / arr[j];
                if (dp[quotient] !== undefined) {
                    dp[arr[i]] = (dp[arr[i]] + dp[arr[j]] * dp[quotient]) % MOD;
                }
            }
        }
    }
    let result = 0;
    for (let key in dp) {
        result = (result + dp[key]) % MOD;
    }
    return result;
};