function getCoprimes(n, edges) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const maxVal = 1000;
    const coprimeMap = new Map();

    for (let i = 1; i <= maxVal; i++) {
        for (let j = i + 1; j <= maxVal; j++) {
            if (gcd(i, j) === 1) {
                if (!coprimeMap.has(i)) coprimeMap.set(i, []);
                coprimeMap.get(i).push(j);
                if (!coprimeMap.has(j)) coprimeMap.set(j, []);
                coprimeMap.get(j).push(i);
            }
        }
    }

    const result = Array(n).fill(0);
    const depth = Array(n).fill(0);
    const ancestors = Array.from({ length: n }, () => []);

    function dfs(node, parent, currentDepth, path) {
        let maxDepth = 0;
        let value = -1;

        for (const val of path) {
            if (coprimeMap.has(val) && coprimeMap.get(val).includes(node)) {
                if (depth[val] > maxDepth) {
                    maxDepth = depth[val];
                    value = val;
                }
            }
        }

        if (value !== -1) {
            result[node] = value;
        } else {
            result[node] = -1;
        }

        depth[node] = currentDepth;
        ancestors[node] = [...path];

        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                dfs(neighbor, node, currentDepth + 1, [...path, node]);
            }
        }
    }

    function gcd(a, b) {
        while (b !== 0) {
            const temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    dfs(0, -1, 0, []);

    return result;
}