const MAXN = 100000;
const isPrime = new Array(MAXN + 1).fill(true);
isPrime[0] = isPrime[1] = false;
for (let p = 2; p * p <= MAXN; ++p) {
    if (isPrime[p]) {
        for (let i = p * p; i <= MAXN; i += p)
            isPrime[i] = false;
    }
}

var countPaths = function(n, edges) {
    const adj = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let totalValidPaths = 0;
    const visitedNonPrime = new Array(n + 1).fill(false);
    const primeAdjComponentSizes = Array.from({ length: n + 1 }, () => []);

    for (let i = 1; i <= n; ++i) {
        if (!isPrime[i] && !visitedNonPrime[i]) {
            const currentComponentNodes = [];

            const dfsComponent = (curr) => {
                visitedNonPrime[curr] = true;
                currentComponentNodes.push(curr);
                for (const neighbor of adj[curr]) {
                    if (!isPrime[neighbor] && !visitedNonPrime[neighbor]) {
                        dfsComponent(neighbor);
                    }
                }
            };
            dfsComponent(i);

            const currentSize = currentComponentNodes.length;
            const adjacentPrimesForThisComponent = new Set();
            for (const nodeInC of currentComponentNodes) {
                for (const neighbor of adj[nodeInC]) {
                    if (isPrime[neighbor]) {
                        adjacentPrimesForThisComponent.add(neighbor);
                    }
                }
            }

            for (const p of adjacentPrimesForThisComponent) {
                primeAdjComponentSizes[p].push(currentSize);
            }
        }
    }

    for (let p = 1; p <= n; ++p) {
        if (isPrime[p]) {
            let sumS = 0;
            if (primeAdjComponentSizes[p].length > 0) {
                for (const s of primeAdjComponentSizes[p]) {
                    totalValidPaths += s;
                    totalValidPaths += sumS * s;
                    sumS += s;
                }
            }
            totalValidPaths += 1;
        }
    }

    return totalValidPaths;
};