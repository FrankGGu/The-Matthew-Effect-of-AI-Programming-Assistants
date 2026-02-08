function countValidPaths(n, edges) {
    const isPrime = new Array(n + 1).fill(true);
    isPrime[0] = isPrime[1] = false;
    for (let i = 2; i * i <= n; i++) {
        if (isPrime[i]) {
            for (let j = i * i; j <= n; j += i) {
                isPrime[j] = false;
            }
        }
    }

    const adj = new Array(n + 1).fill().map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let res = 0;
    const visited = new Set();

    const dfs = (node) => {
        visited.add(node);
        let count = [0, 0];
        if (isPrime[node]) {
            count[1] = 1;
        } else {
            count[0] = 1;
        }

        for (const neighbor of adj[node]) {
            if (!visited.has(neighbor)) {
                const subCount = dfs(neighbor);
                res += subCount[0] * count[1] + subCount[1] * count[0];
                if (isPrime[node]) {
                    count[1] += subCount[0];
                } else {
                    count[0] += subCount[0];
                    count[1] += subCount[1];
                }
            }
        }
        return count;
    };

    dfs(1);
    return res;
}