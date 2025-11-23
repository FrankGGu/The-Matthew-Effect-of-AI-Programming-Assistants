var countValidPaths = function(n, edges) {
    const adj = Array(n + 1).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const isPrime = (num) => {
        if (num <= 1) return false;
        for (let i = 2; i <= Math.sqrt(num); i++) {
            if (num % i === 0) return false;
        }
        return true;
    };

    let totalPaths = 0;

    const dfs = (node, parent, bannedNode) => {
        let count = 1;
        for (const neighbor of adj[node]) {
            if (neighbor !== parent && neighbor !== bannedNode) {
                count += dfs(neighbor, node, bannedNode);
            }
        }
        return count;
    };

    for (let i = 1; i <= n; i++) {
        if (isPrime(i)) {
            continue;
        }
        for (const neighbor of adj[i]) {
            if (isPrime(neighbor)) {
                continue;
            }
            if (i < neighbor) {
                totalPaths += dfs(i, -1, neighbor) * dfs(neighbor, -1, i);
            }
        }
    }

    for (let i = 1; i <= n; i++) {
        if (isPrime(i)) {
            totalPaths += adj[i].length;
        }
    }

    return totalPaths;
};