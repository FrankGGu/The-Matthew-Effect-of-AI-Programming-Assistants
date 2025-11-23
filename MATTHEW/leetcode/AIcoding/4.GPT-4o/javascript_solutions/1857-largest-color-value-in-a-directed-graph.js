var largestColorValue = function(colors, edges) {
    const n = colors.length;
    const graph = new Array(n).fill(0).map(() => []);
    const indegree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        graph[u].push(v);
        indegree[v]++;
    }

    const count = new Array(n).fill(0).map(() => new Array(26).fill(0));
    const queue = [];

    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) {
            queue.push(i);
            count[i][colors[i].charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
    }

    let maxColorValue = 0;

    while (queue.length) {
        const node = queue.shift();
        maxColorValue = Math.max(maxColorValue, ...count[node]);

        for (const neighbor of graph[node]) {
            for (let j = 0; j < 26; j++) {
                count[neighbor][j] = Math.max(count[neighbor][j], count[node][j] + (j === colors[neighbor].charCodeAt(0) - 'a' ? 1 : 0));
            }
            indegree[neighbor]--;
            if (indegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return maxColorValue;
};