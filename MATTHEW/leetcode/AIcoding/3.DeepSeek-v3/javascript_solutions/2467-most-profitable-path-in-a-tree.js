var mostProfitablePath = function(edges, bob, amount) {
    const n = amount.length;
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const parent = new Array(n).fill(-1);
    const depth = new Array(n).fill(0);
    const q = [0];
    parent[0] = -1;

    while (q.length) {
        const u = q.shift();
        for (const v of adj[u]) {
            if (parent[v] === -1 && v !== parent[u]) {
                parent[v] = u;
                depth[v] = depth[u] + 1;
                q.push(v);
            }
        }
    }

    let current = bob;
    let bobSteps = 0;
    const bobTime = new Array(n).fill(Infinity);
    while (current !== -1) {
        bobTime[current] = bobSteps;
        current = parent[current];
        bobSteps++;
    }

    const aliceVisited = new Array(n).fill(false);
    let maxProfit = -Infinity;
    const stack = [[0, 0, amount[0]]];
    aliceVisited[0] = true;

    while (stack.length) {
        const [u, time, profit] = stack.pop();
        let isLeaf = true;

        for (const v of adj[u]) {
            if (!aliceVisited[v] && v !== parent[u]) {
                aliceVisited[v] = true;
                isLeaf = false;
                let newAmount = amount[v];
                if (time + 1 < bobTime[v]) {
                    newAmount = amount[v];
                } else if (time + 1 === bobTime[v]) {
                    newAmount = amount[v] / 2;
                } else {
                    newAmount = 0;
                }
                stack.push([v, time + 1, profit + newAmount]);
            }
        }

        if (isLeaf) {
            maxProfit = Math.max(maxProfit, profit);
        }
    }

    return maxProfit;
};