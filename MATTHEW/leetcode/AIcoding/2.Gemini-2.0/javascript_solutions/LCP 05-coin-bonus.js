var collectTheCoins = function(board) {
    const m = board.length;
    const n = board[0].length;
    let coins = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            coins += board[i][j];
        }
    }

    let degree = Array(m * n).fill(0);
    const adj = Array(m * n).fill(null).map(() => []);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i > 0) {
                adj[i * n + j].push((i - 1) * n + j);
                degree[i * n + j]++;
                adj[(i - 1) * n + j].push(i * n + j);
                degree[(i - 1) * n + j]++;
            }
            if (i < m - 1) {
                adj[i * n + j].push((i + 1) * n + j);
                degree[i * n + j]++;
                adj[(i + 1) * n + j].push(i * n + j);
                degree[(i + 1) * n + j]++;
            }
            if (j > 0) {
                adj[i * n + j].push(i * n + (j - 1));
                degree[i * n + j]++;
                adj[i * n + (j - 1)].push(i * n + j);
                degree[i * n + (j - 1)]++;
            }
            if (j < n - 1) {
                adj[i * n + j].push(i * n + (j + 1));
                degree[i * n + j]++;
                adj[i * n + (j + 1)].push(i * n + j);
                degree[i * n + (j + 1)]++;
            }
        }
    }

    let queue = [];
    for (let i = 0; i < m * n; i++) {
        if (degree[i] <= 1 && board[Math.floor(i / n)][i % n] === 0) {
            queue.push(i);
        }
    }

    while (queue.length > 0) {
        const u = queue.shift();
        coins -= board[Math.floor(u / n)][u % n];
        board[Math.floor(u / n)][u % n] = 0;
        degree[u] = 0;

        for (const v of adj[u]) {
            degree[v]--;
            if (degree[v] === 1 && board[Math.floor(v / n)][v % n] === 0) {
                queue.push(v);
            }
        }
    }

    for (let i = 0; i < m * n; i++) {
        adj[i] = [];
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
             if (board[i][j] === 1) {
                if (i > 0 && board[i-1][j] === 1) {
                    adj[i * n + j].push((i - 1) * n + j);
                    degree[i * n + j]++;
                    adj[(i - 1) * n + j].push(i * n + j);
                    degree[(i - 1) * n + j]++;
                }
                if (i < m - 1 && board[i+1][j] === 1) {
                    adj[i * n + j].push((i + 1) * n + j);
                    degree[i * n + j]++;
                    adj[(i + 1) * n + j].push(i * n + j);
                    degree[(i + 1) * n + j]++;
                }
                if (j > 0 && board[i][j-1] === 1) {
                    adj[i * n + j].push(i * n + (j - 1));
                    degree[i * n + j]++;
                    adj[i * n + (j - 1)].push(i * n + j);
                    degree[i * n + (j - 1)]++;
                }
                if (j < n - 1 && board[i][j+1] === 1) {
                    adj[i * n + j].push(i * n + (j + 1));
                    degree[i * n + j]++;
                    adj[i * n + (j + 1)].push(i * n + j);
                    degree[i * n + (j + 1)]++;
                }
            }
        }
    }
    queue = [];
    for (let i = 0; i < m * n; i++) {
        if (degree[i] === 1 && board[Math.floor(i / n)][i % n] === 1) {
            queue.push(i);
        }
    }

    let removedEdges = 0;
    while (queue.length > 0) {
        const u = queue.shift();
        degree[u] = 0;
        removedEdges++;

        for (const v of adj[u]) {
            degree[v]--;
            if (degree[v] === 1) {
                queue.push(v);
            }
        }
    }
    return coins - removedEdges;
};