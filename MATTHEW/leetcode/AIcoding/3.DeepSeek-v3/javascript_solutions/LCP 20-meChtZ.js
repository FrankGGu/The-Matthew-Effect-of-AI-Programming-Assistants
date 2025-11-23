var busRapidTransit = function(target, inc, dec, jump, cost) {
    const MOD = 1e9 + 7;
    let memo = new Map();

    function dfs(pos) {
        if (pos === 0) return 0;
        if (memo.has(pos)) return memo.get(pos);

        let res = pos * inc;

        for (let i = 0; i < jump.length; i++) {
            let step = jump[i];
            let c = cost[i];
            let prev = Math.floor(pos / step);
            let next = prev + 1;

            if (prev > 0) {
                let cost1 = c + (pos - prev * step) * inc + dfs(prev);
                res = Math.min(res, cost1);
            }

            let cost2 = c + (next * step - pos) * dec + dfs(next);
            res = Math.min(res, cost2);
        }

        memo.set(pos, res);
        return res;
    }

    return dfs(target) % MOD;
};