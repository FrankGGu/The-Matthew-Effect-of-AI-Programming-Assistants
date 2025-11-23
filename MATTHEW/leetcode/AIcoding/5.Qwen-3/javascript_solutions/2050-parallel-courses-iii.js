function minimumTimeToCompleteCourse(n, relations) {
    const graph = new Array(n).fill(0).map(() => []);
    const inDegree = new Array(n).fill(0);

    for (const [prev, next] of relations) {
        graph[prev - 1].push(next - 1);
        inDegree[next - 1]++;
    }

    const queue = [];
    const time = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    while (queue.length > 0) {
        const current = queue.shift();
        for (const neighbor of graph[current]) {
            inDegree[neighbor]--;
            time[neighbor] = Math.max(time[neighbor], time[current] + 1);
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return Math.max(...time);
}