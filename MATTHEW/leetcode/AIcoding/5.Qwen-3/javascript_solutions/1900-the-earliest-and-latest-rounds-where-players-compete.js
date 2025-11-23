function earliestAndLatest(n, firstPlayer, secondPlayer) {
    const memo = {};

    function dfs(a, b, rounds) {
        const key = `${a},${b},${rounds}`;
        if (memo[key] !== undefined) return memo[key];

        if (a === b) {
            return [rounds, rounds];
        }

        let minRound = Infinity;
        let maxRound = -Infinity;

        for (let i = 1; i <= n; i++) {
            if (i === a || i === b) continue;
            const nextA = Math.min(a, i);
            const nextB = Math.max(a, i);
            const nextC = Math.min(b, i);
            const nextD = Math.max(b, i);

            if (nextA === nextC) {
                const res = dfs(nextA, nextC, rounds + 1);
                minRound = Math.min(minRound, res[0]);
                maxRound = Math.max(maxRound, res[1]);
            } else if (nextA === nextD) {
                const res = dfs(nextA, nextD, rounds + 1);
                minRound = Math.min(minRound, res[0]);
                maxRound = Math.max(maxRound, res[1]);
            } else if (nextB === nextC) {
                const res = dfs(nextB, nextC, rounds + 1);
                minRound = Math.min(minRound, res[0]);
                maxRound = Math.max(maxRound, res[1]);
            } else if (nextB === nextD) {
                const res = dfs(nextB, nextD, rounds + 1);
                minRound = Math.min(minRound, res[0]);
                maxRound = Math.max(maxRound, res[1]);
            }
        }

        memo[key] = [minRound, maxRound];
        return [minRound, maxRound];
    }

    return dfs(firstPlayer, secondPlayer, 1);
}