var minimumDivisionOperations = function(nums, divisors) {
    const n = nums.length;
    const m = divisors.length;
    const target = nums.slice();

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    function divide(index, divisorIndex) {
        nums[index] = Math.floor(nums[index] / divisors[divisorIndex]);
    }

    const dp = Array(n).fill(null).map(() => Array(1 << m).fill(Infinity));

    dp[0][0] = 0;

    for (let i = 0; i < n; i++) {
        for (let mask = 0; mask < (1 << m); mask++) {
            if (dp[i][mask] === Infinity) continue;

            if (i === n - 1) {
                continue;
            }

            // Don't divide
            if (nums[i] <= nums[i + 1]) {
                dp[i + 1][mask] = Math.min(dp[i + 1][mask], dp[i][mask]);
            }

            // Divide
            for (let j = 0; j < m; j++) {
                if ((mask & (1 << j)) === 0) {
                    const originalValue = nums[i+1];
                    divide(i + 1, j);
                    if (nums[i] <= nums[i + 1]) {
                        dp[i + 1][mask | (1 << j)] = Math.min(dp[i + 1][mask | (1 << j)], dp[i][mask] + 1);
                    }
                    nums[i+1] = originalValue;
                }
            }
            nums[i] = target[i];
            for(let k=0; k<i; k++){
                nums[k] = target[k];
            }
        }
        if(i + 1 < n){
            nums[i+1] = target[i+1];
        }
    }

    let result = Infinity;
    for (let mask = 0; mask < (1 << m); mask++) {
        result = Math.min(result, dp[n - 1][mask]);
    }

    if (result === Infinity) return -1;
    return result;
};