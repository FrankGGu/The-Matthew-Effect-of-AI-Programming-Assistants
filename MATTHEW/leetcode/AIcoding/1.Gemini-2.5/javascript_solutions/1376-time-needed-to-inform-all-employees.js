var numOfMinutes = function(n, headID, manager, informTime) {
    let adj = new Array(n).fill(0).map(() => []);

    for (let i = 0; i < n; i++) {
        if (manager[i] !== -1) {
            adj[manager[i]].push(i);
        }
    }

    let maxTime = 0;

    function dfs(employeeId, currentAccumulatedTime) {
        maxTime = Math.max(maxTime, currentAccumulatedTime);

        for (let subordinate of adj[employeeId]) {
            dfs(subordinate, currentAccumulatedTime + informTime[employeeId]);
        }
    }

    dfs(headID, 0);

    return maxTime;
};