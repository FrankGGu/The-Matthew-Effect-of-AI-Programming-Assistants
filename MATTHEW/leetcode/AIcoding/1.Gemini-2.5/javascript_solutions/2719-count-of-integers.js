var count = function(num1, num2, min_sum, max_sum) {
    const MOD = 10 ** 9 + 7;

    function solve(numStr, min_sum, max_sum) {
        const n = numStr.length;
        const memo = Array(n).fill(0).map(() =>
            Array(9 * n + 1).fill(0).map(() =>
                Array(2).fill(-1)
            )
        );

        function dp(index, currentSum, isTight) {
            if (currentSum > max_sum) {
                return 0;
            }
            if (index === n) {
                return (currentSum >= min_sum) ? 1 : 0;
            }

            if (memo[index][currentSum][isTight] !== -1) {
                return memo[index][currentSum][isTight];
            }

            let ans = 0;
            const upperLimit = isTight ? parseInt(numStr[index]) : 9;

            for (let digit = 0; digit <= upperLimit; digit++) {
                const newIsTight = isTight && (digit === upperLimit);
                ans = (ans + dp(index + 1, currentSum + digit, newIsTight)) % MOD;
            }

            return memo[index][currentSum][isTight] = ans;
        }
        return dp(0, 0, true);
    }

    function subtractOne(numStr) {
        let n = numStr.length;
        let arr = numStr.split('').map(Number);
        let i = n - 1;
        while (i >= 0) {
            if (arr[i] > 0) {
                arr[i]--;
                break;
            } else {
                arr[i] = 9;
                i--;
            }
        }
        if (arr[0] === 0 && n > 1) {
            return arr.slice(1).join('');
        }
        return arr.join('');
    }

    const countUpToNum2 = solve(num2, min_sum, max_sum);
    const num1Minus1 = subtractOne(num1);
    const countUpToNum1Minus1 = solve(num1Minus1, min_sum, max_sum);

    let result = (countUpToNum2 - countUpToNum1Minus1 + MOD) % MOD;

    return result;
};