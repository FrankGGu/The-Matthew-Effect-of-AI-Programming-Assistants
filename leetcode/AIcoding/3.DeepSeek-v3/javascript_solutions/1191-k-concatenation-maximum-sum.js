var kConcatenationMaxSum = function(arr, k) {
    const MOD = 1e9 + 7;
    let maxSubArray = (nums) => {
        let max = 0, current = 0;
        for (let num of nums) {
            current = Math.max(num, current + num);
            max = Math.max(max, current);
        }
        return max;
    };

    if (k === 1) {
        return maxSubArray(arr) % MOD;
    }

    let sum = arr.reduce((a, b) => a + b, 0);
    let doubleArr = [...arr, ...arr];
    let maxDouble = maxSubArray(doubleArr);

    if (sum > 0) {
        return Math.max(maxDouble, maxDouble + (k - 2) * sum) % MOD;
    } else {
        return Math.max(0, maxDouble) % MOD;
    }
};