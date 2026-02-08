var maxKDivisibleComponents = function(n, edges, values, k) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let componentCount = 0;

    function dfs(u, parent) {
        let currentSubtreeSum = values[u];

        for (const v of adj[u]) {
            if (v === parent) {
                continue;
            }
            currentSubtreeSum += dfs(v, u);
        }

        if (currentSubtreeSum % k === 0) {
            componentCount++;
            return 0; 
        } else {
            return currentSubtreeSum; 
        }
    }

    dfs(0, -1); 

    return componentCount;
};