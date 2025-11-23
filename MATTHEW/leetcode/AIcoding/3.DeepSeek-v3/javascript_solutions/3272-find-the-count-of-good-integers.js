var countGoodIntegers = function(low, high, k) {
    function countGood(n) {
        const s = n.toString();
        const len = s.length;
        const memo = new Array(len).fill().map(() => new Array(2).fill().map(() => new Array(2).fill(-1)));

        function dp(pos, tight, leadingZero, sumMod) {
            if (pos === len) {
                return sumMod === 0 && !leadingZero ? 1 : 0;
            }
            if (memo[pos][tight][leadingZero ? 1 : 0][sumMod] !== -1) {
                return memo[pos][tight][leadingZero ? 1 : 0][sumMod];
            }

            let limit = tight ? parseInt(s[pos]) : 9;
            let res = 0;

            for (let d = 0; d <= limit; d++) {
                const newTight = tight && (d === limit);
                const newLeadingZero = leadingZero && (d === 0);
                let newSumMod = sumMod;
                if (!newLeadingZero) {
                    newSumMod = (sumMod + d) % k;
                }
                res += dp(pos + 1, newTight, newLeadingZero, newSumMod);
            }

            memo[pos][tight][leadingZero ? 1 : 0][sumMod] = res;
            return res;
        }

        return dp(0, true, true, 0);
    }

    return countGood(high) - countGood(low - 1);
};