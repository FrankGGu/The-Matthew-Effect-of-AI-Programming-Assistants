var minNumberOfSemesters = function(n, relations, k) {
    const graph = Array.from({ length: n }, () => []);
    const indegree = new Array(n).fill(0);

    for (const [u, v] of relations) {
        graph[u - 1].push(v - 1);
        indegree[v - 1]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) {
            queue.push(i);
        }
    }

    let semesters = 0;

    while (queue.length) {
        const nextQueue = [];
        const count = Math.min(queue.length, k);
        for (let i = 0; i < count; i++) {
            const course = queue.shift();
            for (const neighbor of graph[course]) {
                indegree[neighbor]--;
                if (indegree[neighbor] === 0) {
                    nextQueue.push(neighbor);
                }
            }
        }
        semesters++;
        queue.push(...nextQueue);
    }

    return semesters;
};