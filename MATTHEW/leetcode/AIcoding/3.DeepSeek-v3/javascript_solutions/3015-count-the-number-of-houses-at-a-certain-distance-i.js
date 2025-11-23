var countOfPairs = function(n, x, y) {
    let dist = Array.from({ length: n + 1 }, () => Array(n + 1).fill(Infinity));
    for (let i = 1; i <= n; i++) {
        dist[i][i] = 0;
        if (i < n) dist[i][i + 1] = 1;
        if (i > 1) dist[i][i - 1] = 1;
    }
    dist[x][y] = 1;
    dist[y][x] = 1;

    for (let k = 1; k <= n; k++) {
        for (let i = 1; i <= n; i++) {
            for (let j = 1; j <= n; j++) {
                if (dist[i][j] > dist[i][k] + dist[k][j]) {
                    dist[i][j] = dist[i][k] + dist[k][j];
                }
            }
        }
    }

    let res = Array(n).fill(0);
    for (let i = 1; i <= n; i++) {
        for (let j = i + 1; j <= n; j++) {
            let d = dist[i][j];
            if (d <= n) {
                res[d - 1] += 2;
            }
        }
    }
    return res;
};