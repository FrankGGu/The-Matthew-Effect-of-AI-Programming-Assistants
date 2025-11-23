var maximizeTheNumberOfTargetNodes = function(n, edges, k, target) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const visited = new Array(n).fill(false);
    const componentTargetCounts = [];

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            let currentComponentTargetCount = 0;
            const stack = [i];
            visited[i] = true;

            while (stack.length > 0) {
                const node = stack.pop();
                if (target[node] === 1) {
                    currentComponentTargetCount++;
                }

                for (const neighbor of adj[node]) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        stack.push(neighbor);
                    }
                }
            }
            componentTargetCounts.push(currentComponentTargetCount);
        }
    }

    componentTargetCounts.sort((a, b) => b - a);

    let maxTargetNodes = 0;
    const numComponentsToSelect = Math.min(componentTargetCounts.length, k + 1);

    for (let i = 0; i < numComponentsToSelect; i++) {
        maxTargetNodes += componentTargetCounts[i];
    }

    return maxTargetNodes;
};