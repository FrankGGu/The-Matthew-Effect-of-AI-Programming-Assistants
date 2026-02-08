var countPartitions = function(nums, k) {
    const MOD = 10**9 + 7;
    let sum = 0;
    for (let num of nums) {
        sum = (sum + num) % MOD;
    }

    if (sum % 2 !== 0) {
        return 0;
    }

    let n = nums.length;
    let dp = new Array(sum / 2 + 1).fill(0);
    dp[0] = 1;

    for (let num of nums) {
        for (let j = sum / 2; j >= num; j--) {
            dp[j] = (dp[j] + dp[j - num]) % MOD;
        }
    }

    let totalSubsets = 1;
    for (let i = 0; i < n; i++) {
        totalSubsets = (totalSubsets * 2) % MOD;
    }

    let invalidSubsets = (dp[sum / 2] * 2) % MOD;

    if (k === 0) {
        return (totalSubsets - invalidSubsets + MOD) % MOD;
    }

    let invalid = 0;
    for(let num of nums){
        if(num > k){
            invalid++;
        }
    }

    if(invalid > 0){
        return totalSubsets;
    }
    let ans = (totalSubsets - invalidSubsets + MOD) % MOD;
    return ans;
};