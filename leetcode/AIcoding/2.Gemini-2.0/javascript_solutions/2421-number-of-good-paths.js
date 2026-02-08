var numberOfGoodPaths = function(vals, edges) {
    const n = vals.length;
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const parent = Array(n).fill(0).map((_, i) => i);
    const size = Array(n).fill(1);

    function find(i) {
        if (parent[i] === i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    function union(i, j) {
        const rootI = find(i);
        const rootJ = find(j);
        if (rootI !== rootJ) {
            if (size[rootI] < size[rootJ]) {
                parent[rootI] = rootJ;
                size[rootJ] += size[rootI];
            } else {
                parent[rootJ] = rootI;
                size[rootI] += size[rootJ];
            }
        }
    }

    const sortedNodes = Array(n).fill(0).map((_, i) => i).sort((a, b) => vals[a] - vals[b]);

    const counts = Array(n).fill(0);
    let ans = n;

    for (const node of sortedNodes) {
        const val = vals[node];
        for (const neighbor of adj[node]) {
            if (vals[neighbor] <= val) {
                const rootNode = find(node);
                const rootNeighbor = find(neighbor);
                if (rootNode !== rootNeighbor) {
                    ans += counts[rootNode] * counts[rootNeighbor];
                    union(node, neighbor);
                }
            }
        }
        counts[find(node)]++;
    }

    return ans;
};