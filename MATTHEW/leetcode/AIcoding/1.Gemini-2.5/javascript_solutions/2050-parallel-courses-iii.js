var minimumTime = function(n, relations, duration) {
    const adj = Array(n + 1).fill(0).map(() => []);
    const indegree = Array(n + 1).fill(0);
    const earliestFinishTime = Array(n + 1).fill(0);

    for (const [prev, next] of relations) {
        adj[prev].push(next);
        indegree[next]++;
    }

    const queue = [];
    for (let i = 1; i <= n; i++) {
        earliestFinishTime[i] = duration[i - 1];
        if (indegree[i] === 0) {
            queue.push(i);
        }
    }

    let head = 0;
    while (head < queue.length) {
        const u = queue[head++];

        for (const v of adj[u]) {
            earliestFinishTime[v] = Math.max(earliestFinishTime[v], earliestFinishTime[u] + duration[v - 1]);
            indegree[v]--;
            if (indegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    let maxTime = 0;
    for (let i = 1; i <= n; i++) {
        maxTime = Math.max(maxTime, earliestFinishTime[i]);
    }

    return maxTime;
};