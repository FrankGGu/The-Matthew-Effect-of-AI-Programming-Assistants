var numOfMinutes = function(n, headID, manager, informTime) {
    let adj = new Array(n).fill(null).map(() => []);
    for (let i = 0; i < n; i++) {
        if (manager[i] !== -1) {
            adj[manager[i]].push(i);
        }
    }

    let maxTime = 0;
    function dfs(node, time) {
        maxTime = Math.max(maxTime, time);
        for (let neighbor of adj[node]) {
            dfs(neighbor, time + informTime[node]);
        }
    }

    dfs(headID, 0);
    return maxTime;
};