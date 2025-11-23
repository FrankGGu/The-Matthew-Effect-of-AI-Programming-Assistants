var chaseGame = function(edges, startA, startB) {
    const n = edges.length;
    const adj = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const getDistances = (start) => {
        const dist = new Array(n + 1).fill(-1);
        const queue = [start];
        dist[start] = 0;
        while (queue.length) {
            const u = queue.shift();
            for (const v of adj[u]) {
                if (dist[v] === -1) {
                    dist[v] = dist[u] + 1;
                    queue.push(v);
                }
            }
        }
        return dist;
    };

    const distA = getDistances(startA);
    const distB = getDistances(startB);

    let maxDist = 0;
    for (let i = 1; i <= n; i++) {
        if (distA[i] > distB[i] + 1) {
            maxDist = Math.max(maxDist, distA[i]);
        }
    }

    if (maxDist === 0) {
        return 1;
    }

    const findCycle = () => {
        const parent = new Array(n + 1).fill(0);
        const visited = new Array(n + 1).fill(false);
        const stack = [];
        let cycleLength = 0;

        const dfs = (u, p) => {
            visited[u] = true;
            parent[u] = p;
            stack.push(u);
            for (const v of adj[u]) {
                if (v === p) continue;
                if (visited[v]) {
                    let current = u;
                    let length = 1;
                    while (current !== v) {
                        current = parent[current];
                        length++;
                    }
                    if (length >= 3) {
                        cycleLength = length;
                        return true;
                    }
                } else {
                    if (dfs(v, u)) return true;
                }
            }
            stack.pop();
            return false;
        };

        for (let i = 1; i <= n; i++) {
            if (!visited[i] && dfs(i, -1)) {
                return cycleLength;
            }
        }
        return 0;
    };

    const cycleLen = findCycle();
    if (cycleLen >= 3 && maxDist > cycleLen - 2) {
        return -1;
    } else {
        return maxDist;
    }
};