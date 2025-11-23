var countCombinations = function(pieces, positions) {
    const n = pieces.length;
    let ans = 0;

    const dx = [0, 0, 1, -1, 1, 1, -1, -1];
    const dy = [1, -1, 0, 0, 1, -1, 1, -1];

    function isValid(x, y) {
        return x >= 1 && x <= 8 && y >= 1 && y <= 8;
    }

    function solve(idx, states, moves) {
        if (idx === n) {
            const occupied = new Array(9).fill(null).map(() => new Array(9).fill(false));
            let collision = false;

            for (let step = 1; ; step++) {
                let moved = false;
                for (let i = 0; i < n; i++) {
                    if (states[i] > 0) continue;

                    const [x, y] = moves[i][step];
                    if (!isValid(x, y)) continue;

                    moved = true;
                    if (occupied[x][y]) {
                        collision = true;
                        break;
                    }
                }
                if (collision) break;

                if (!moved) {
                    ans++;
                    return;
                }

                for (let i = 0; i < n; i++) {
                    if (states[i] > 0) continue;

                    const [x, y] = moves[i][step];
                    if (isValid(x, y)) {
                        occupied[x][y] = true;
                    }
                }
            }

            return;
        }

        const x = positions[idx][0];
        const y = positions[idx][1];

        let directions = [];
        if (pieces[idx] === 'queen') {
            directions = [0, 1, 2, 3, 4, 5, 6, 7];
        } else if (pieces[idx] === 'rook') {
            directions = [0, 1, 2, 3];
        } else {
            directions = [4, 5, 6, 7];
        }

        for (const dir of directions) {
            const currentMoves = [[x, y]];
            let cx = x;
            let cy = y;
            while (true) {
                cx += dx[dir];
                cy += dy[dir];
                if (!isValid(cx, cy)) break;
                currentMoves.push([cx, cy]);
            }

            let allMoves = [];
            for (let i = 0; i <= currentMoves.length; i++) {
                allMoves.push(currentMoves.slice(0, i));
            }

            for (const move of allMoves) {
                const numMoves = move.length -1;
                const extendedMoves = new Array(9).fill(null).map(() => new Array(9).fill(null));
                for (let i = 0; i < move.length; i++) {
                    extendedMoves[i+1] = move[i];
                }

                const newStates = [...states];
                newStates[idx] = numMoves;
                solve(idx + 1, newStates, [...moves, extendedMoves]);

            }
        }
    }

    solve(0, new Array(n).fill(0), []);
    return ans;
};