var rootCount = function(n, edges, guesses, k) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let correctGuesses = 0;
    const guessSet = new Set();
    for (const [u, v] of guesses) {
        guessSet.add(u * n + v);
    }

    function dfs(node, parent) {
        let count = 0;
        if (guessSet.has(parent * n + node)) {
            count++;
        }
        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                count += dfs(neighbor, node);
            }
        }
        return count;
    }

    correctGuesses = dfs(0, -1);
    let ans = 0;
    function reroot(node, parent, correct) {
        if (correct >= k) {
            ans++;
        }

        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                let newCorrect = correct;
                if (guessSet.has(node * n + neighbor)) {
                    newCorrect--;
                }
                if (guessSet.has(neighbor * n + node)) {
                    newCorrect++;
                }
                reroot(neighbor, node, newCorrect);
            }
        }
    }

    reroot(0, -1, correctGuesses);

    return ans;
};