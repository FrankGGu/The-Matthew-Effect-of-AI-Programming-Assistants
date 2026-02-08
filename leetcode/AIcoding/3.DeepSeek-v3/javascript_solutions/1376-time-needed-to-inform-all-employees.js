var numOfMinutes = function(n, headID, manager, informTime) {
    const adj = new Array(n).fill(0).map(() => []);
    for (let i = 0; i < n; i++) {
        if (manager[i] !== -1) {
            adj[manager[i]].push(i);
        }
    }

    const queue = [[headID, 0]];
    let maxTime = 0;

    while (queue.length) {
        const [current, time] = queue.shift();
        maxTime = Math.max(maxTime, time);

        for (const subordinate of adj[current]) {
            queue.push([subordinate, time + informTime[current]]);
        }
    }

    return maxTime;
};