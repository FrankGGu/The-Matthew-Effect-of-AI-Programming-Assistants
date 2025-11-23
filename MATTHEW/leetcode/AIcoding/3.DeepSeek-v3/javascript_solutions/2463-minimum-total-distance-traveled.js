var minimumTotalDistance = function(robot, factory) {
    robot.sort((a, b) => a - b);
    factory.sort((a, b) => a[0] - b[0]);

    const memo = new Map();

    function dp(i, j, k) {
        if (i === robot.length) return 0;
        if (j === factory.length) return Infinity;
        const key = `${i},${j},${k}`;
        if (memo.has(key)) return memo.get(key);

        let res = dp(i, j + 1, 0);
        if (k < factory[j][1]) {
            const cost = Math.abs(robot[i] - factory[j][0]) + dp(i + 1, j, k + 1);
            res = Math.min(res, cost);
        }

        memo.set(key, res);
        return res;
    }

    return dp(0, 0, 0);
};