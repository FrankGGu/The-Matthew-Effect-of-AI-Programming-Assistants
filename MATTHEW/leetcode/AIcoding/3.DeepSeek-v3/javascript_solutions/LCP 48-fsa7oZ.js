var canMouseWin = function(grid, catJump, mouseJump) {
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const m = grid.length, n = grid[0].length;
    let mousePos, catPos, foodPos;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 'M') mousePos = [i, j];
            else if (grid[i][j] === 'C') catPos = [i, j];
            else if (grid[i][j] === 'F') foodPos = [i, j];
        }
    }

    const memo = new Map();

    function dfs(mouse, cat, turn) {
        if (turn > 100) return false;
        const key = `${mouse[0]},${mouse[1]},${cat[0]},${cat[1]},${turn % 2}`;
        if (memo.has(key)) return memo.get(key);

        if (turn % 2 === 0) {
            for (const [dx, dy] of dirs) {
                for (let jump = 0; jump <= mouseJump; jump++) {
                    const x = mouse[0] + dx * jump;
                    const y = mouse[1] + dy * jump;
                    if (x < 0 || x >= m || y < 0 || y >= n || grid[x][y] === '#') break;
                    if (x === foodPos[0] && y === foodPos[1]) {
                        memo.set(key, true);
                        return true;
                    }
                    if (x === cat[0] && y === cat[1]) continue;
                    if (dfs([x, y], cat, turn + 1)) {
                        memo.set(key, true);
                        return true;
                    }
                }
            }
            memo.set(key, false);
            return false;
        } else {
            for (const [dx, dy] of dirs) {
                for (let jump = 0; jump <= catJump; jump++) {
                    const x = cat[0] + dx * jump;
                    const y = cat[1] + dy * jump;
                    if (x < 0 || x >= m || y < 0 || y >= n || grid[x][y] === '#') break;
                    if (x === foodPos[0] && y === foodPos[1] || (x === mouse[0] && y === mouse[1])) {
                        memo.set(key, false);
                        return false;
                    }
                    if (!dfs(mouse, [x, y], turn + 1)) {
                        memo.set(key, false);
                        return false;
                    }
                }
            }
            memo.set(key, true);
            return true;
        }
    }

    return dfs(mousePos, catPos, 0);
};