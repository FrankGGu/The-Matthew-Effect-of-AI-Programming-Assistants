var squareFreeSubsets = function(nums) {
    const MOD = 1000000007;
    const maxNum = Math.max(...nums);
    const isSquareFree = new Array(maxNum + 1).fill(true);

    for (let i = 2; i * i <= maxNum; i++) {
        for (let j = i * i; j <= maxNum; j += i * i) {
            isSquareFree[j] = false;
        }
    }

    const count = new Array(maxNum + 1).fill(0);
    for (const num of nums) {
        if (isSquareFree[num]) count[num]++;
    }

    const dp = new Array(1 << nums.length).fill(0);
    dp[0] = 1;

    for (let mask = 0; mask < dp.length; mask++) {
        let prod = 1;
        for (let i = 0; i < nums.length; i++) {
            if (mask & (1 << i)) {
                prod *= nums[i];
                if (!isSquareFree[nums[i]]) prod = 0;
            }
        }
        for (let i = 0; i < nums.length; i++) {
            if (!(mask & (1 << i))) {
                if (prod * nums[i] <= maxNum && isSquareFree[prod * nums[i]]) {
                    dp[mask | (1 << i)] = (dp[mask | (1 << i)] + dp[mask]) % MOD;
                }
            }
        }
    }

    let result = 0;
    for (let mask = 1; mask < dp.length; mask++) {
        result = (result + dp[mask]) % MOD;
    }

    return result;
};