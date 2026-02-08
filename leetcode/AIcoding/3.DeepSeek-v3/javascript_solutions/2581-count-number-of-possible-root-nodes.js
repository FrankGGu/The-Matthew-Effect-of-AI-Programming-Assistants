var rootCount = function(edges, guesses, k) {
    const n = edges.length + 1;
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const guessSet = new Set();
    for (const [u, v] of guesses) {
        guessSet.add(`${u},${v}`);
    }

    let correct = 0;
    const parent = new Array(n).fill(-1);
    const stack = [0];
    parent[0] = -1;

    while (stack.length) {
        const u = stack.pop();
        for (const v of adj[u]) {
            if (parent[v] === -1 && v !== parent[u]) {
                parent[v] = u;
                stack.push(v);
                if (guessSet.has(`${u},${v}`)) {
                    correct++;
                }
            }
        }
    }

    let res = 0;
    const stack2 = [[0, correct]];
    const visited = new Array(n).fill(false);
    visited[0] = true;

    while (stack2.length) {
        const [u, current] = stack2.pop();
        if (current >= k) {
            res++;
        }
        for (const v of adj[u]) {
            if (!visited[v]) {
                visited[v] = true;
                let newCurrent = current;
                if (guessSet.has(`${u},${v}`)) {
                    newCurrent--;
                }
                if (guessSet.has(`${v},${u}`)) {
                    newCurrent++;
                }
                stack2.push([v, newCurrent]);
            }
        }
    }

    return res;
};