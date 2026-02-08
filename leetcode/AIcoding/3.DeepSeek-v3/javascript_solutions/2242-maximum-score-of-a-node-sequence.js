var maximumScore = function(scores, edges) {
    const n = scores.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    for (let i = 0; i < n; i++) {
        graph[i].sort((a, b) => scores[b] - scores[a]);
        graph[i] = graph[i].slice(0, 3);
    }

    let maxScore = -1;

    for (const [u, v] of edges) {
        for (const x of graph[u]) {
            if (x === v) continue;
            for (const y of graph[v]) {
                if (y === u || y === x) continue;
                const currentScore = scores[u] + scores[v] + scores[x] + scores[y];
                if (currentScore > maxScore) {
                    maxScore = currentScore;
                }
            }
        }
    }

    return maxScore;
};