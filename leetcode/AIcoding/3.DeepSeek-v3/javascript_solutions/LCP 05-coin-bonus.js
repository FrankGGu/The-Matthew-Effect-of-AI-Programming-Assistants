var bonus = function(n, leadership, operations) {
    const MOD = 1e9 + 7;
    const tree = Array.from({ length: n + 1 }, () => []);
    const parent = new Array(n + 1).fill(0);
    const children = Array.from({ length: n + 1 }, () => []);

    for (const [u, v] of leadership) {
        tree[u].push(v);
        parent[v] = u;
        children[u].push(v);
    }

    const inTime = new Array(n + 1).fill(0);
    const outTime = new Array(n + 1).fill(0);
    let time = 0;

    function dfs(node) {
        inTime[node] = ++time;
        for (const child of children[node]) {
            dfs(child);
        }
        outTime[node] = time;
    }

    dfs(1);

    const BITSize = n + 2;
    const BIT1 = new Array(BITSize).fill(0);
    const BIT2 = new Array(BITSize).fill(0);

    function update(BIT, idx, delta) {
        while (idx < BITSize) {
            BIT[idx] = (BIT[idx] + delta) % MOD;
            idx += idx & -idx;
        }
    }

    function query(BIT, idx) {
        let res = 0;
        while (idx > 0) {
            res = (res + BIT[idx]) % MOD;
            idx -= idx & -idx;
        }
        return res;
    }

    function rangeAdd(l, r, delta) {
        update(BIT1, l, delta);
        update(BIT1, r + 1, -delta);
        update(BIT2, l, delta * (l - 1) % MOD);
        update(BIT2, r + 1, -delta * r % MOD);
    }

    function rangeQuery(l, r) {
        const sumR = (query(BIT1, r) * r % MOD - query(BIT2, r) + MOD) % MOD;
        const sumL = (query(BIT1, l - 1) * (l - 1) % MOD - query(BIT2, l - 1) + MOD) % MOD;
        return (sumR - sumL + MOD) % MOD;
    }

    const res = [];

    for (const op of operations) {
        if (op[0] === 1) {
            const u = op[1];
            const coin = op[2];
            const l = inTime[u];
            const r = inTime[u];
            rangeAdd(l, r, coin);
        } else if (op[0] === 2) {
            const u = op[1];
            const coin = op[2];
            const l = inTime[u];
            const r = outTime[u];
            rangeAdd(l, r, coin);
        } else if (op[0] === 3) {
            const u = op[1];
            const l = inTime[u];
            const r = outTime[u];
            const sum = rangeQuery(l, r);
            res.push(sum);
        }
    }

    return res;
};