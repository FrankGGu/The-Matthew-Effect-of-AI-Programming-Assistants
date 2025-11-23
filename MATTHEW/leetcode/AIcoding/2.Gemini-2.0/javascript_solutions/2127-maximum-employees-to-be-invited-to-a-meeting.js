var maximumInvitations = function(favorite) {
    const n = favorite.length;
    const adj = Array(n).fill(null).map(() => []);
    const indegree = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        adj[favorite[i]].push(i);
        indegree[i]++;
    }

    let queue = [];
    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) {
            queue.push(i);
        }
    }

    const depth = Array(n).fill(1);
    while (queue.length > 0) {
        const u = queue.shift();
        for (const v of adj[u]) {
            depth[v] = Math.max(depth[v], depth[u] + 1);
            indegree[v]--;
            if (indegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    let cycleSum = 0;
    let maxChain = 0;

    for (let i = 0; i < n; i++) {
        if (indegree[i] > 0) {
            let j = i;
            let count = 0;
            while (indegree[j] > 0) {
                indegree[j] = -1;
                j = favorite[j];
                count++;
            }
            cycleSum += count;
        }
    }

    for (let i = 0; i < n; i++) {
        if (favorite[favorite[i]] === i) {
            maxChain += depth[i] + depth[favorite[i]];
            favorite[i] = -1;
            favorite[favorite[i]] = -1;
        }
    }

    return Math.max(cycleSum, maxChain);
};