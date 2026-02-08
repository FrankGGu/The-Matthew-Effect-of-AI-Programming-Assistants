var domino = function(n, m, broken) {
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const brokenSet = new Set();
    for (const [x, y] of broken) {
        brokenSet.add(`${x},${y}`);
    }

    const board = new Array(n).fill(0).map(() => new Array(m).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (brokenSet.has(`${i},${j}`)) {
                board[i][j] = 1;
            }
        }
    }

    const match = new Array(n * m).fill(-1);
    const visited = new Array(n * m).fill(false);

    function dfs(u) {
        const x = Math.floor(u / m);
        const y = u % m;
        if (board[x][y] === 1) return false;

        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < n && ny >= 0 && ny < m && board[nx][ny] === 0) {
                const v = nx * m + ny;
                if (!visited[v]) {
                    visited[v] = true;
                    if (match[v] === -1 || dfs(match[v])) {
                        match[u] = v;
                        match[v] = u;
                        return true;
                    }
                }
            }
        }
        return false;
    }

    let res = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if ((i + j) % 2 === 0 && board[i][j] === 0) {
                const u = i * m + j;
                visited.fill(false);
                if (dfs(u)) res++;
            }
        }
    }
    return res;
};