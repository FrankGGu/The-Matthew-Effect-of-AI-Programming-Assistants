var countSteppingNumbers = function(low, high) {
    const MOD = 1e9 + 7;
    const memo = {};

    function dfs(pos, prev, tight, leadingZero, s) {
        if (pos === s.length) {
            return leadingZero ? 0 : 1;
        }
        const key = `${pos}_${prev}_${tight}_${leadingZero}`;
        if (memo[key] !== undefined) {
            return memo[key];
        }

        let limit = tight ? parseInt(s[pos]) : 9;
        let total = 0;

        for (let digit = 0; digit <= limit; digit++) {
            const newTight = tight && (digit === limit);
            const newLeadingZero = leadingZero && (digit === 0);

            if (newLeadingZero) {
                total += dfs(pos + 1, prev, newTight, newLeadingZero, s);
            } else {
                if (leadingZero || Math.abs(digit - prev) === 1) {
                    total += dfs(pos + 1, digit, newTight, newLeadingZero, s);
                }
            }
            total %= MOD;
        }

        memo[key] = total;
        return total;
    }

    function countNumbers(s) {
        memo = {};
        return dfs(0, 0, true, true, s);
    }

    const lowNum = BigInt(low);
    const highNum = BigInt(high);

    let result = (countNumbers(high) - countNumbers(low) + MOD) % MOD;

    let isLowStepping = true;
    for (let i = 1; i < low.length; i++) {
        if (Math.abs(parseInt(low[i]) - parseInt(low[i - 1])) !== 1) {
            isLowStepping = false;
            break;
        }
    }

    if (isLowStepping) {
        result = (result + 1) % MOD;
    }

    return result;
};