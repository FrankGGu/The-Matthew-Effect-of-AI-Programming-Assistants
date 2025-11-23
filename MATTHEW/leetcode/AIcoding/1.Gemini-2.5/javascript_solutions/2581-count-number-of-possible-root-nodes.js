var countPossibleRootNodes = function(n, edges, guesses, k) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const guessSet = new Set();
    for (const [u, v] of guesses) {
        guessSet.add(`${u},${v}`);
    }

    const dpCorrect = new Array(n).fill(0);

    function dfs1(u, p) {
        for (const v of adj[u]) {
            if (v === p) continue;
            dfs1(v, u);
            dpCorrect[u] += dpCorrect[v];
            if (guessSet.has(`${u},${v}`)) {
                dpCorrect[u]++;
            }
        }
    }

    dfs1(0, -1);

    let resultCount = 0;

    function dfs2(u, p, currentCorrectGuesses) {
        if (currentCorrectGuesses >= k) {
            resultCount++;
        }

        for (const v of adj[u]) {
            if (v === p) continue;

            let nextCorrectGuesses = currentCorrectGuesses;

            if (guessSet.has(`${u},${v}`)) {
                nextCorrectGuesses--;
            }
            if (guessSet.has(`${v},${u}`)) {
                nextCorrectGuesses++;
            }

            dfs2(v, u, nextCorrectGuesses);
        }
    }

    dfs2(0, -1, dpCorrect[0]);

    return resultCount;
};