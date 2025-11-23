var updateMatrix = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const dist = Array(m).fill(0).map(() => Array(n).fill(Infinity));
    const queue = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 0) {
                dist[i][j] = 0;
                queue.push([i, j]);
            }
        }
    }

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
    let head = 0;

    while (head < queue.length) {
        const [r, c] = queue[head++];

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                if (dist[nr][nc] > dist[r][c] + 1) {
                    dist[nr][nc] = dist[r][c] + 1;
                    queue.push([nr, nc]);
                }
            }
        }
    }

    return dist;
};