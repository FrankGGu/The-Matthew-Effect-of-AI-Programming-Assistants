var getProbability = function(balls) {
    const n = balls.length;
    let totalBalls = 0;
    for (const b of balls) {
        totalBalls += b;
    }
    const halfTotalBalls = totalBalls / 2;

    const memo = new Map();

    const combinations = (n, k) => {
        if (k < 0 || k > n) return 0;
        if (k === 0 || k === n) return 1;
        if (k > n / 2) k = n - k;
        let res = 1;
        for (let i = 1; i <= k; i++) {
            res = res * (n - i + 1) / i;
        }
        return res;
    };

    const solve = (idx, count1, count2, distinct1, distinct2) => {
        if (idx === n) {
            if (count1 === halfTotalBalls && count2 === halfTotalBalls) {
                if (distinct1 === distinct2) {
                    return [1, 1];
                } else {
                    return [0, 1];
                }
            }
            return [0, 0];
        }

        const key = `${idx}-${count1}-${distinct1}-${distinct2}`;
        if (memo.has(key)) {
            return memo.get(key);
        }

        let currentFavorableWays = 0;
        let currentTotalWays = 0;

        for (let k = 0; k <= balls[idx]; k++) {
            const ballsToBox2 = balls[idx] - k;

            if (count1 + k > halfTotalBalls || count2 + ballsToBox2 > halfTotalBalls) {
                continue;
            }

            const nextDistinct1 = distinct1 + (k > 0 ? 1 : 0);
            const nextDistinct2 = distinct2 + (ballsToBox2 > 0 ? 1 : 0);

            const waysToDistributeCurrentColor = combinations(balls[idx], k);

            const [subFavorable, subTotal] = solve(
                idx + 1,
                count1 + k,
                count2 + ballsToBox2,
                nextDistinct1,
                nextDistinct2
            );

            currentFavorableWays += waysToDistributeCurrentColor * subFavorable;
            currentTotalWays += waysToDistributeCurrentColor * subTotal;
        }

        memo.set(key, [currentFavorableWays, currentTotalWays]);
        return memo.get(key);
    };

    const [favorableWays, totalWays] = solve(0, 0, 0, 0, 0);

    return totalWays === 0 ? 0 : favorableWays / totalWays;
};