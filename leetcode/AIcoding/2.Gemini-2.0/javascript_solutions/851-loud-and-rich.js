var loudAndRich = function(richer, quiet) {
    const n = quiet.length;
    const adj = Array(n).fill(null).map(() => []);
    const inDegree = Array(n).fill(0);

    for (const [u, v] of richer) {
        adj[u].push(v);
        inDegree[v]++;
    }

    const answer = Array(n).fill(null).map((_, i) => i);

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    while (queue.length > 0) {
        const u = queue.shift();

        for (const v of adj[u]) {
            if (quiet[answer[u]] < quiet[answer[v]]) {
                answer[v] = answer[u];
            }
            inDegree[v]--;
            if (inDegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return answer;
};