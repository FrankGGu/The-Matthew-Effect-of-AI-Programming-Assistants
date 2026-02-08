var canMouseWin = function(board, catJump, mouseJump) {
    const R = board.length;
    const C = board[0].length;

    let mouseStartR, mouseStartC;
    let catStartR, catStartC;

    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            if (board[r][c] === 'M') {
                mouseStartR = r;
                mouseStartC = c;
            } else if (board[r][c] === 'C') {
                catStartR = r;
                catStartC = c;
            }
        }
    }

    // memo[cat_r][cat_c][mouse_r][mouse_c][turn_idx]
    // turn_idx: 0 for mouse, 1 for cat
    // Result: 0 (Draw), 1 (Mouse wins), 2 (Cat wins)
    const memo = Array(R).fill(0).map(() =>
        Array(C).fill(0).map(() =>
            Array(R).fill(0).map(() =>
                Array(C).fill(0).map(() =>
                    Array(2).fill(undefined)
                )
            )
        )
    );

    const dr = [-1, 1, 0, 0];
    const dc = [0, 0, -1, 1];

    // Max turns to detect a draw (cycle).
    // The number of distinct game states is R * C * R * C * 2.
    // If the game exceeds this many turns, it implies a cycle without a win, thus a draw.
    const MAX_TURNS = R * C * R * C * 2; 

    function isValid(r, c) {
        return r >= 0 && r < R && c >= 0 && c < C && board[r][c] !== '#';
    }

    // Returns 0 (Draw), 1 (Mouse wins), 2 (Cat wins)
    function solve(cr, cc, mr, mc, turn_idx, k) {
        // Base case for draw due to excessive turns
        if (k >= MAX_TURNS) {
            return 0; // Draw
        }

        // Check memoization
        if (memo[cr][cc][mr][mc][turn_idx] !== undefined) {
            return memo[cr][cc][mr][mc][turn_idx];
        }

        // Immediate win conditions
        // Cat catches mouse
        if (cr === mr && cc === mc) {
            memo[cr][cc][mr][mc][turn_idx] = 2; // Cat wins
            return 2;
        }
        // Mouse reaches food
        if (board[mr][mc] === 'F') {
            memo[cr][cc][mr][mc][turn_idx] = 1; // Mouse wins
            return 1;
        }

        if (turn_idx === 0) { // Mouse's turn
            let mouseCanWin = false;
            let mouseCanDraw = false;

            // Mouse can stay put (jump = 0) or move up to mouseJump steps
            for (let i = 0; i < dr.length; i++) {
                for (let jump = 0; jump <= mouseJump; jump++) {
                    let nmr = mr + dr[i] * jump;
                    let nmc = mc + dc[i] * jump;

                    // Check path validity
                    let pathBlocked = false;
                    for (let s = 1; s <= jump; s++) {
                        if (!isValid(mr + dr[i] * s, mc + dc[i] * s)) {
                            pathBlocked = true;
                            break;
                        }
                    }
                    if (pathBlocked) continue;

                    if (!isValid(nmr, nmc)) continue; // Target cell must be valid

                    // Valid move for mouse
                    let res = solve(cr, cc, nmr, nmc, 1, k + 1); // Next is cat's turn
                    if (res === 1) { // Mouse found a winning move
                        mouseCanWin = true;
                        break; 
                    } else if (res === 0) { // Mouse found a drawing move
                        mouseCanDraw = true;
                    }
                }
                if (mouseCanWin) break;
            }

            if (mouseCanWin) {
                memo[cr][cc][mr][mc][turn_idx] = 1;
                return 1;
            }
            if (mouseCanDraw) {
                memo[cr][cc][mr][mc][turn_idx] = 0;
                return 0;
            }
            // If mouse cannot win and cannot draw, all moves lead to cat win.
            // This also covers the case where mouse has no valid moves.
            memo[cr][cc][mr][mc][turn_idx] = 2;
            return 2;

        } else { // Cat's turn (turn_idx === 1)
            let catCanWin = false;
            let catCanDraw = false;

            // Cat can stay put (jump = 0) or move up to catJump steps
            for (let i = 0; i < dr.length; i++) {
                for (let jump = 0; jump <= catJump; jump++) {
                    let ncr = cr + dr[i] * jump;
                    let ncc = cc + dc[i] * jump;

                    // Check path validity
                    let pathBlocked = false;
                    for (let s = 1; s <= jump; s++) {
                        if (!isValid(cr + dr[i] * s, cc + dc[i] * s)) {
                            pathBlocked = true;
                            break;
                        }
                    }
                    if (pathBlocked) continue;

                    if (!isValid(ncr, ncc)) continue; // Target cell must be valid

                    // Valid move for cat
                    let res = solve(ncr, ncc, mr, mc, 0, k + 1); // Next is mouse's turn
                    if (res === 2) { // Cat found a winning move
                        catCanWin = true;
                        break;
                    } else if (res === 0) { // Cat found a drawing move
                        catCanDraw = true;
                    }
                }
                if (catCanWin) break;
            }

            if (catCanWin) {
                memo[cr][cc][mr][mc][turn_idx] = 2;
                return 2;
            }
            if (catCanDraw) {
                memo[cr][cc][mr][mc][turn_idx] = 0;
                return 0;
            }
            // If cat cannot win and cannot draw, all moves lead to mouse win.
            // This also covers the case where cat has no valid moves.
            memo[cr][cc][mr][mc][turn_idx] = 1;
            return 1;
        }
    }

    // Initial call: Mouse's turn (turn_idx = 0), 0 turns elapsed
    return solve(catStartR, catStartC, mouseStartR, mouseStartC, 0, 0) === 1;
};