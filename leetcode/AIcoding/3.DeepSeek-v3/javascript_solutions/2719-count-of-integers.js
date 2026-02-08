var count = function(num1, num2, min_sum, max_sum) {
    const MOD = 1e9 + 7;

    function calculate(s) {
        const n = s.length;
        const memo = new Array(n).fill().map(() => new Array(400).fill(-1).map(() => new Array(2).fill(-1)));

        function dp(pos, sum, tight) {
            if (pos === n) {
                return sum >= min_sum && sum <= max_sum ? 1 : 0;
            }
            if (memo[pos][sum][tight] !== -1) {
                return memo[pos][sum][tight];
            }

            let limit = tight ? parseInt(s[pos]) : 9;
            let res = 0;

            for (let d = 0; d <= limit; d++) {
                let newTight = tight && (d === limit);
                let newSum = sum + d;
                res = (res + dp(pos + 1, newSum, newTight)) % MOD;
            }

            memo[pos][sum][tight] = res;
            return res;
        }

        return dp(0, 0, true);
    }

    function isNumValid(num) {
        let sum = 0;
        for (let c of num) {
            sum += parseInt(c);
        }
        return sum >= min_sum && sum <= max_sum;
    }

    let total = (calculate(num2) - calculate(num1) + (isNumValid(num1) ? 1 : 0);
    return (total % MOD + MOD) % MOD;
};