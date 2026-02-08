var maximizeTargetNodes = function(n, edges, isTarget, k) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const visited = Array(n).fill(false);
    const componentTargetCounts = [];

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            let currentComponentTargets = 0;
            const stack = [i];
            visited[i] = true;

            while (stack.length > 0) {
                const node = stack.pop();
                if (isTarget[node]) {
                    currentComponentTargets++;
                }

                for (const neighbor of adj[node]) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        stack.push(neighbor);
                    }
                }
            }
            componentTargetCounts.push(currentComponentTargets);
        }
    }

    componentTargetCounts.sort((a, b) => b - a);

    let maxTargets = 0;
    const componentsToConnect = Math.min(componentTargetCounts.length, k + 1);
    for (let i = 0; i < componentsToConnect; i++) {
        maxTargets += componentTargetCounts[i];
    }

    return maxTargets;
};