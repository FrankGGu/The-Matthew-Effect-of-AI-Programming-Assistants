var minimumTime = function(n, relations, time) {
    const graph = new Array(n + 1).fill(0).map(() => []);
    const inDegree = new Array(n + 1).fill(0);
    const maxTime = new Array(n + 1).fill(0);

    for (const [prev, next] of relations) {
        graph[prev].push(next);
        inDegree[next]++;
    }

    const queue = [];
    for (let i = 1; i <= n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
            maxTime[i] = time[i - 1];
        }
    }

    let result = 0;
    while (queue.length > 0) {
        const u = queue.shift();
        result = Math.max(result, maxTime[u]);

        for (const v of graph[u]) {
            maxTime[v] = Math.max(maxTime[v], maxTime[u] + time[v - 1]);
            inDegree[v]--;
            if (inDegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return result;
};