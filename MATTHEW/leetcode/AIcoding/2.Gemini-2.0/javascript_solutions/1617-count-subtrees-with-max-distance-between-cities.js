var countSubtrees = function(n, edges) {
    const adj = Array(n + 1).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const dist = (mask, start) => {
        const q = [[start, 0]];
        const visited = new Set();
        visited.add(start);
        let maxDist = 0;
        let farthestNode = start;

        while (q.length > 0) {
            const [node, d] = q.shift();
            if (!((mask >> (node - 1)) & 1)) continue;

            if (d > maxDist) {
                maxDist = d;
                farthestNode = node;
            }

            for (const neighbor of adj[node]) {
                if (!visited.has(neighbor) && ((mask >> (neighbor - 1)) & 1)) {
                    q.push([neighbor, d + 1]);
                    visited.add(neighbor);
                }
            }
        }

        let count = 0;
        for (let i = 1; i <= n; i++) {
            if ((mask >> (i - 1)) & 1) {
                count++;
            }
        }

        if (visited.size !== count) return [-1, -1];
        return [maxDist, farthestNode];
    };

    const diameter = (mask) => {
        let [_, start] = dist(mask, 1);
        if (start === -1) return -1;
        let [maxDist, _] = dist(mask, start);
        return maxDist;
    };

    const result = Array(n - 1).fill(0);
    for (let mask = 1; mask < (1 << n); mask++) {
        if (mask === 0) continue;
        const d = diameter(mask);
        if (d > 0) {
            result[d - 1]++;
        }
    }

    return result;
};