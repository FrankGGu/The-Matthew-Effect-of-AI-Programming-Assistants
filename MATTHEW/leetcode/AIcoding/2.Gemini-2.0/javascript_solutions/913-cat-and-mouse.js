var catMouseGame = function(graph) {
    const n = graph.length;
    const DRAW = 0, MOUSE = 1, CAT = 2;
    const dp = Array(n).fill(null).map(() => Array(n).fill(null).map(() => Array(2 * n).fill(0)));

    function getResult(mouse, cat, turn) {
        if (turn === 2 * n) {
            return DRAW;
        }
        if (dp[mouse][cat][turn] !== 0) {
            return dp[mouse][cat][turn];
        }
        if (mouse === cat) {
            dp[mouse][cat][turn] = CAT;
            return CAT;
        }
        if (mouse === 0) {
            dp[mouse][cat][turn] = MOUSE;
            return MOUSE;
        }

        if (turn % 2 === 0) { // Mouse's turn
            let result = CAT;
            for (const nextMouse of graph[mouse]) {
                let nextResult = getResult(nextMouse, cat, turn + 1);
                if (nextResult === MOUSE) {
                    result = MOUSE;
                    break;
                } else if (nextResult === DRAW) {
                    result = DRAW;
                }
            }
            dp[mouse][cat][turn] = result;
            return result;
        } else { // Cat's turn
            let result = MOUSE;
            for (const nextCat of graph[cat]) {
                if (nextCat !== 0) {
                    let nextResult = getResult(mouse, nextCat, turn + 1);
                    if (nextResult === CAT) {
                        result = CAT;
                        break;
                    } else if (nextResult === DRAW) {
                        result = DRAW;
                    }
                }
            }
            dp[mouse][cat][turn] = result;
            return result;
        }
    }

    return getResult(1, 2, 0);
};