var minNumberOfSemesters = function(n, relations, k) {
    const graph = Array.from({length: n + 1}, () => []);
    const indegree = Array(n + 1).fill(0);

    for (const [u, v] of relations) {
        graph[u].push(v);
        indegree[v]++;
    }

    const queue = [];
    for (let i = 1; i <= n; i++) {
        if (indegree[i] === 0) queue.push(i);
    }

    let semesters = 0;

    while (queue.length > 0) {
        semesters++;
        const size = Math.min(queue.length, k);
        const nextQueue = [];

        for (let i = 0; i < size; i++) {
            const course = queue.shift();
            for (const neighbor of graph[course]) {
                indegree[neighbor]--;
                if (indegree[neighbor] === 0) nextQueue.push(neighbor);
            }
        }

        for (const next of nextQueue) {
            queue.push(next);
        }
    }

    return semesters;
};