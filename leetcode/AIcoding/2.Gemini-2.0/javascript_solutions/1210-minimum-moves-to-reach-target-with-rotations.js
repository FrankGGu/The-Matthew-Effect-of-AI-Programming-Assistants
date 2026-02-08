var minimumMoves = function(n, blocked) {
    const blockedSet = new Set(blocked.map(b => b[0] + "," + b[1]));
    if (blockedSet.size > 0) {
        const nearBlocked = (x, y) => {
            for (let i = -1; i <= 1; i++) {
                for (let j = -1; j <= 1; j++) {
                    if (Math.abs(i) + Math.abs(j) !== 1) continue;
                    if (x + i < 0 || x + i >= n || y + j < 0 || y + j >= n) continue;
                    if (blockedSet.has((x + i) + "," + (y + j))) return true;
                }
            }
            return false;
        };

        if (nearBlocked(0, 0) || nearBlocked(0, 1)) {
            return -1;
        }
    }

    const q = [[[0, 0], 0]];
    const visited = new Set();
    visited.add("0,0,0");

    while (q.length > 0) {
        const [[x, y], moves] = q.shift();

        if (x === n - 1 && y === n - 2) {
            return moves;
        }

        const nextMoves = [];

        // Move right
        if (y + 2 < n && !blockedSet.has(x + "," + (y + 2)) && !visited.has(x + "," + (y + 1) + ",0")) {
            nextMoves.push([[x, y + 1], moves + 1]);
        }

        // Move down
        if (x + 1 < n && !blockedSet.has((x + 1) + "," + y) && !blockedSet.has((x + 1) + "," + (y + 1)) && !visited.has((x + 1) + "," + y + ",0")) {
            nextMoves.push([[x + 1, y], moves + 1]);
        }

        // Rotate clockwise
        if (x + 1 < n && y + 1 < n && !blockedSet.has((x + 1) + "," + (y + 1)) && !blockedSet.has((x + 1) + "," + y) && !visited.has(x + "," + y + ",1")) {
            nextMoves.push([[x, y], moves + 1]);
        }

        // Rotate counterclockwise
        if (x - 1 >= 0 && y + 1 < n && !blockedSet.has(x + "," + (y + 1)) && !blockedSet.has((x - 1) + "," + (y + 1)) && !visited.has((x - 1) + "," + (y + 1) + ",0")) {
            nextMoves.push([[x - 1, y + 1], moves + 1]);
        }

        // Vertical
        if (x === n - 2 && y === n - 1) {
             if (x + 2 < n && !blockedSet.has((x+2) + "," + y) && !visited.has((x+1) + "," + y + ",1")) {
                nextMoves.push([[x+1, y], moves + 1]);
            }

            if (y + 1 < n && !blockedSet.has((x) + "," + (y+1)) && !blockedSet.has((x+1) + "," + (y+1)) && !visited.has((x) + "," + y + ",0")) {
                nextMoves.push([[x, y], moves + 1]);
            }

            if (x + 1 < n && y - 1 >= 0 && !blockedSet.has((x + 1) + "," + y) && !blockedSet.has((x + 1) + "," + (y -1)) && !visited.has((x + 1) + "," + (y - 1) + ",1")) {
               nextMoves.push([[x + 1, y - 1], moves + 1]);
            }

            if (x + 1 < n && y + 1 < n && !blockedSet.has((x + 1) + "," + (y)) && !blockedSet.has((x) + "," + (y + 1)) && !visited.has((x) + "," + (y) + ",0")) {
                nextMoves.push([[x, y], moves + 1]);
            }
        }

        // Horizontal
        if (x === n - 1 && y === n - 2) {
            // Move right
             if (y + 2 < n && !blockedSet.has((x) + "," + (y + 2)) && !visited.has((x) + "," + (y + 1) + ",0")) {
                nextMoves.push([[x, y+1], moves + 1]);
            }
            // Move down
            if (x + 1 < n && !blockedSet.has((x + 1) + "," + y) && !blockedSet.has((x + 1) + "," + (y + 1)) && !visited.has((x + 1) + "," + y + ",0")) {
                nextMoves.push([[x + 1, y], moves + 1]);
            }

            if (x + 1 < n && y + 1 < n && !blockedSet.has((x + 1) + "," + (y + 1)) && !blockedSet.has((x + 1) + "," + y) && !visited.has((x) + "," + (y) + ",1")) {
                 nextMoves.push([[x, y], moves + 1]);
            }

            if (x - 1 >= 0 && y + 1 < n && !blockedSet.has((x) + "," + (y + 1)) && !blockedSet.has((x - 1) + "," + (y + 1)) && !visited.has((x - 1) + "," + (y + 1) + ",0")) {
                nextMoves.push([[x - 1, y + 1], moves + 1]);
            }
        }

        for (const [[nx, ny], nmoves] of nextMoves) {
             const key = nx + "," + ny + ",0";
            if (!visited.has(key)) {
                visited.add(key);
                q.push([[nx, ny], nmoves]);
            }
        }
    }

    return -1;
};