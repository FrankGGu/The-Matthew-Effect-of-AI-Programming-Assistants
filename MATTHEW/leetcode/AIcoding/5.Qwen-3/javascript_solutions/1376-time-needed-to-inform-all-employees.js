function numOfMinutes(n, headID, manager, informTime) {
    const graph = new Map();

    for (let i = 0; i < n; i++) {
        if (!graph.has(manager[i])) {
            graph.set(manager[i], []);
        }
        graph.get(manager[i]).push(i);
    }

    function dfs(node) {
        let maxTime = 0;
        if (graph.has(node)) {
            for (const sub of graph.get(node)) {
                maxTime = Math.max(maxTime, dfs(sub));
            }
        }
        return maxTime + informTime[node];
    }

    return dfs(headID);
}