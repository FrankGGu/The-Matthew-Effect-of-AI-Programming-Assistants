function catMouseGame(mouse, cat, move) {
    const MOUSE_WIN = 0;
    const CAT_WIN = 1;
    const DRAW = 2;
    const MAX_MOVES = 100;

    const graph = {};
    for (let i = 0; i < mouse * 2; i++) {
        graph[i] = [];
    }

    for (let i = 0; i < mouse * 2; i++) {
        for (let j = 0; j < cat * 2; j++) {
            for (let k = 0; k < 2; k++) {
                graph[i * 2 + j * 2 + k] = [];
            }
        }
    }

    for (let i = 0; i < mouse * 2; i++) {
        for (let j = 0; j < cat * 2; j++) {
            for (let k = 0; k < 2; k++) {
                const pos = i * 2 + j * 2 + k;
                for (let next = 0; next < mouse * 2; next++) {
                    if (next !== i) {
                        graph[pos].push(next * 2 + j * 2 + 1 - k);
                    }
                }
                for (let next = 0; next < cat * 2; next++) {
                    if (next !== j) {
                        graph[pos].push(i * 2 + next * 2 + 1 - k);
                    }
                }
            }
        }
    }

    const memo = {};
    const dfs = (m, c, turn) => {
        const key = m * 2 + c * 2 + turn;
        if (memo[key] !== undefined) {
            return memo[key];
        }

        if (m === 0) return MOUSE_WIN;
        if (m === cat * 2) return CAT_WIN;
        if (turn === MAX_MOVES) return DRAW;

        const isMouseTurn = turn % 2 === 0;
        let result = isMouseTurn ? CAT_WIN : MOUSE_WIN;

        for (const next of graph[m * 2 + c * 2 + turn]) {
            const res = dfs(next >> 1, next & 1, turn + 1);
            if (isMouseTurn) {
                if (res === MOUSE_WIN) {
                    result = MOUSE_WIN;
                    break;
                } else if (res === DRAW) {
                    result = DRAW;
                }
            } else {
                if (res === CAT_WIN) {
                    result = CAT_WIN;
                    break;
                } else if (res === DRAW) {
                    result = DRAW;
                }
            }
        }

        memo[key] = result;
        return result;
    };

    return dfs(mouse, cat, 0);
}