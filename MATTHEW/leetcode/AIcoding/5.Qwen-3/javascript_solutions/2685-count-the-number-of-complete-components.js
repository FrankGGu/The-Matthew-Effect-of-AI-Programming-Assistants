function countCompleteComponents(graph) {
    const n = graph.length;
    const visited = new Array(n).fill(false);
    let completeComponents = 0;

    function dfs(node, component) {
        visited[node] = true;
        component.push(node);
        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, component);
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            const component = [];
            dfs(i, component);
            const size = component.length;
            let isComplete = true;
            for (const node of component) {
                if (graph[node].length !== size - 1) {
                    isComplete = false;
                    break;
                }
            }
            if (isComplete) {
                completeComponents++;
            }
        }
    }

    return completeComponents;
}