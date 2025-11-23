var numberOfBeautifulIntegers = function(low, high, k) {

    function countBeautiful(N, k) {
        const numStr = N.toString();
        const n = numStr.length;

        const memo = new Array(n).fill(0).map(() =>
            new Array(2).fill(0).map(() =>
                new Array(2).fill(0).map(() =>
                    new Array(n + 1).fill(0).map(() =>
                        new Array(n + 1).fill(0).map(() =>
                            new Array(k).fill(-1)
                        )
                    )
                )
            )
        );

        function dp(index, tight, isLeadingZero, evenCnt, oddCnt, currentMod) {
            if (index === n) {
                return (isLeadingZero || evenCnt !== oddCnt || currentMod !== 0) ? 0 : 1;
            }

            if (memo[index][tight][isLeadingZero][evenCnt][oddCnt][currentMod] !== -1) {
                return memo[index][tight][isLeadingZero][evenCnt][oddCnt][currentMod];
            }

            let ans = 0;
            const upperBound = tight ? parseInt(numStr[index]) : 9;

            for (let digit = 0; digit <= upperBound; digit++) {
                if (isLeadingZero && digit === 0) {
                    ans += dp(index + 1,
                              tight && (digit === upperBound),
                              true,
                              0,
                              0,
                              0);
                } else {
                    const newEvenCnt = evenCnt + (digit % 2 === 0 ? 1 : 0);
                    const newOddCnt = oddCnt + (digit % 2 !== 0 ? 1 : 0);
                    const newMod = (currentMod * 10 + digit) % k;

                    ans += dp(index + 1,
                              tight && (digit === upperBound),
                              false,
                              newEvenCnt,
                              newOddCnt,
                              newMod);
                }
            }

            return memo[index][tight][isLeadingZero][evenCnt][oddCnt][currentMod] = ans;
        }

        return dp(0, true, true, 0, 0, 0);
    }

    return countBeautiful(high, k) - countBeautiful(low - 1, k);
};