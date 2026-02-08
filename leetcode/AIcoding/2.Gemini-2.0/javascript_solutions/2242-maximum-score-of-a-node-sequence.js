var maximumScore = function(scores, edges) {
    const n = scores.length;
    const adj = Array(n).fill(null).map(() => []);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    for (let i = 0; i < n; i++) {
        adj[i].sort((a, b) => scores[b] - scores[a]);
        if (adj[i].length > 3) {
            adj[i] = adj[i].slice(0, 3);
        }
    }

    let maxScore = -1;

    for (const [a, b] of edges) {
        for (const c of adj[a]) {
            if (c === a || c === b) continue;
            for (const d of adj[b]) {
                if (d === a || d === b || d === c) continue;
                maxScore = Math.max(maxScore, scores[a] + scores[b] + scores[c] + scores[d]);
            }
        }
    }

    return maxScore;
};