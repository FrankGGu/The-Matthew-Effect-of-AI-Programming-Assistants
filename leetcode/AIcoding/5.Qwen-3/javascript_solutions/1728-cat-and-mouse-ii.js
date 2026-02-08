function canMouseWin(grid, catJump, mouseJump) {
    const MOUSE_WIN = 0;
    const CAT_WIN = 1;
    const DRAW = 2;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const m = grid.length;
    const n = grid[0].length;
    let mousePos = [-1, -1];
    let catPos = [-1, -1];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 'M') mousePos = [i, j];
            else if (grid[i][j] === 'C') catPos = [i, j];
        }
    }

    const state = {};
    const memo = {};

    function getKey(mouse, cat, turn) {
        return `${mouse[0]},${mouse[1]},${cat[0]},${cat[1]},${turn}`;
    }

    function getMove(pos, jump) {
        const res = [];
        for (const [dx, dy] of dirs) {
            for (let step = 1; step <= jump; step++) {
                const x = pos[0] + dx * step;
                const y = pos[1] + dy * step;
                if (x < 0 || x >= m || y < 0 || y >= n || grid[x][y] === 'W') break;
                res.push([x, y]);
            }
        }
        return res;
    }

    function dfs(mouse, cat, turn) {
        const key = getKey(mouse, cat, turn);
        if (key in memo) return memo[key];

        const mouseWin = grid[mouse[0]][mouse[1]] === 'H';
        const catWin = mouse[0] === cat[0] && mouse[1] === cat[1];
        if (mouseWin) return MOUSE_WIN;
        if (catWin) return CAT_WIN;
        if (turn === 2 * (m * n)) return DRAW;

        const isMouseTurn = turn % 2 === 0;
        const moves = isMouseTurn ? getMove(mouse, mouseJump) : getMove(cat, catJump);
        if (moves.length === 0) {
            return isMouseTurn ? CAT_WIN : MOUSE_WIN;
        }

        let result = isMouseTurn ? CAT_WIN : MOUSE_WIN;
        for (const move of moves) {
            const nextMouse = isMouseTurn ? move : mouse;
            const nextCat = isMouseTurn ? cat : move;
            const res = dfs(nextMouse, nextCat, turn + 1);
            if (isMouseTurn) {
                if (res === MOUSE_WIN) {
                    result = MOUSE_WIN;
                    break;
                }
            } else {
                if (res === CAT_WIN) {
                    result = CAT_WIN;
                    break;
                }
            }
        }

        memo[key] = result;
        return result;
    }

    return dfs(mousePos, catPos, 0) === MOUSE_WIN;
}