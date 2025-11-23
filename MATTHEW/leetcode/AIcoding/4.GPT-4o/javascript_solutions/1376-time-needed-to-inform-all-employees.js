var numOfMinutes = function(n, headID, manager, informTime) {
    const graph = new Map();
    for (let i = 0; i < n; i++) {
        if (!graph.has(manager[i])) {
            graph.set(manager[i], []);
        }
        graph.get(manager[i]).push(i);
    }

    const dfs = (node) => {
        let maxTime = 0;
        for (const child of graph.get(node) || []) {
            maxTime = Math.max(maxTime, dfs(child));
        }
        return maxTime + informTime[node];
    };

    return dfs(headID);
};