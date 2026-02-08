var catAndMouse = function(graph) {
    const N = graph.length;

    // States: (mouse_pos, cat_pos, turn_parity)
    // turn_parity: 0 for mouse's turn, 1 for cat's turn

    // Results:
    // 0: UNCOMPUTED (initial state for memoization table)
    // 1: MOUSE_WINS
    // 2: CAT_WINS
    // 3: DRAW
    // 4: VISITING (used for cycle detection during DFS to indicate a state is currently in the recursion stack)

    const UNCOMPUTED = 0;
    const MOUSE_WINS = 1;
    const CAT_WINS = 2;
    const DRAW = 3;
    const VISITING = 4;

    // memo[mouse][cat][turn_parity]
    // Initialize with UNCOMPUTED (0)
    const memo = Array(N).fill(0).map(() =>
        Array(N).fill(0).map(() =>
            Array(2).fill(UNCOMPUTED)
        )
    );

    // Recursive DFS function
    // m: mouse position
    // c: cat position
    // p: turn_parity (0 for mouse, 1 for cat)
    function dfs(m, c, p) {
        // Base cases for immediate wins/losses
        if (m === 0) {
            return MOUSE_WINS;
        }
        if (m === c) {
            return CAT_WINS;
        }

        // Check memoization table
        if (memo[m][c][p] !== UNCOMPUTED) {
            return memo[m][c][p];
        }

        // Mark current state as VISITING to detect cycles
        memo[m][c][p] = VISITING;

        let result;

        if (p === 0) { // Mouse's turn
            let mouseCanWin = false;
            let mouseCanDraw = false;

            // Mouse tries to move to a winning state
            for (const nextM of graph[m]) {
                const nextResult = dfs(nextM, c, 1); // Next turn is cat's
                if (nextResult === MOUSE_WINS) {
                    mouseCanWin = true;
                    break; // Mouse found a winning move, takes it
                }
                if (nextResult === DRAW || nextResult === VISITING) {
                    // If next state is DRAW or a cycle (VISITING), mouse can potentially draw
                    mouseCanDraw = true;
                }
            }

            if (mouseCanWin) {
                result = MOUSE_WINS;
            } else if (mouseCanDraw) {
                result = DRAW;
            } else {
                result = CAT_WINS; // All moves lead to cat winning
            }
        } else { // Cat's turn (p === 1)
            let catCanWin = false;
            let catCanDraw = false;

            // Cat tries to move to a winning state
            for (const nextC of graph[c]) {
                if (nextC === 0) {
                    // Cat cannot move to hole 0
                    continue;
                }
                const nextResult = dfs(m, nextC, 0); // Next turn is mouse's
                if (nextResult === CAT_WINS) {
                    catCanWin = true;
                    break; // Cat found a winning move, takes it
                }
                if (nextResult === DRAW || nextResult === VISITING) {
                    // If next state is DRAW or a cycle (VISITING), cat can potentially draw
                    catCanDraw = true;
                }
            }

            if (catCanWin) {
                result = CAT_WINS;
            } else if (catCanDraw) {
                result = DRAW;
            } else {
                result = MOUSE_WINS; // All moves lead to mouse winning
            }
        }

        // Store and return the final result for this state
        memo[m][c][p] = result;
        return result;
    }

    // Start the game: mouse at 1, cat at 2, mouse's turn (0)
    // The problem asks for 0: Draw, 1: Mouse wins, 2: Cat wins
    // My DRAW constant is 3, so map it back to 0.
    const finalResult = dfs(1, 2, 0);
    return finalResult === DRAW ? 0 : finalResult;
};