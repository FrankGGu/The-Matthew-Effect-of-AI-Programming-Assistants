function numOfMinutes(n, headID, manager, informTime) {
    const graph = new Array(n).fill(0).map(() => []);
    for (let i = 0; i < n; i++) {
        if (manager[i] !== -1) {
            graph[manager[i]].push(i);
        }
    }

    function dfs(node) {
        let maxTime = 0;
        for (const child of graph[node]) {
            maxTime = Math.max(maxTime, dfs(child));
        }
        return maxTime + informTime[node];
    }

    return dfs(headID);
}