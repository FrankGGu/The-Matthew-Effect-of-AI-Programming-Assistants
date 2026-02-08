var getAncestors = function(n, edges) {
    const adjRev = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adjRev[v].push(u);
    }

    const result = Array(n).fill(0).map(() => []);

    for (let i = 0; i < n; i++) {
        const visited = new Set();
        const ancestors = [];

        const dfs = (currentNode) => {
            visited.add(currentNode);

            for (const parentOfCurrent of adjRev[currentNode]) {
                if (!visited.has(parentOfCurrent)) {
                    ancestors.push(parentOfCurrent);
                    dfs(parentOfCurrent);
                }
            }
        };

        dfs(i);

        ancestors.sort((a, b) => a - b);
        result[i] = ancestors;
    }

    return result;
};