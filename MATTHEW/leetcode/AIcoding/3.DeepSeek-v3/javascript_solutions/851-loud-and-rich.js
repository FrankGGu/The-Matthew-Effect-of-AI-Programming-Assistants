var loudAndRich = function(richer, quiet) {
    const n = quiet.length;
    const graph = Array.from({ length: n }, () => []);
    const inDegree = new Array(n).fill(0);
    const answer = new Array(n).fill(0).map((_, i) => i);

    for (const [a, b] of richer) {
        graph[a].push(b);
        inDegree[b]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    while (queue.length) {
        const u = queue.shift();
        for (const v of graph[u]) {
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