var countUnhappyFriends = function(n, preferences, pairs) {
    const rank = Array(n).fill(0).map(() => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n - 1; j++) {
            rank[i][preferences[i][j]] = j;
        }
    }

    const pairedWith = Array(n);
    for (const [x, y] of pairs) {
        pairedWith[x] = y;
        pairedWith[y] = x;
    }

    let unhappyCount = 0;
    for (let x = 0; x < n; x++) {
        const y = pairedWith[x];
        for (let u = 0; u < n; u++) {
            if (u === x || u === y) {
                continue;
            }

            // Check if x prefers u over y
            if (rank[x][u] < rank[x][y]) {
                const v = pairedWith[u];
                // Check if u prefers x over v
                if (rank[u][x] < rank[u][v]) {
                    unhappyCount++;
                    break; // x is unhappy, no need to check further u's for this x
                }
            }
        }
    }

    return unhappyCount;
};