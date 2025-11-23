var countCombinations = function(pieces, positions) {
    const directions = {
        'rook': [[0, 1], [1, 0], [0, -1], [-1, 0]],
        'bishop': [[1, 1], [1, -1], [-1, 1], [-1, -1]],
        'queen': [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [1, -1], [-1, 1], [-1, -1]]
    };

    const n = pieces.length;
    const paths = [];

    for (let i = 0; i < n; i++) {
        const [x, y] = positions[i];
        const piece = pieces[i];
        const dirs = directions[piece];
        const path = [];

        for (const [dx, dy] of dirs) {
            for (let step = 1; step <= 8; step++) {
                const nx = x + dx * step;
                const ny = y + dy * step;
                if (nx < 1 || nx > 8 || ny < 1 || ny > 8) break;
                path.push([nx, ny]);
            }
        }
        path.push([x, y]);
        paths.push(path);
    }

    let res = 0;
    const used = new Set();

    const backtrack = (index, current) => {
        if (index === n) {
            const key = current.map(pos => `${pos[0]},${pos[1]}`).join('|');
            if (!used.has(key)) {
                used.add(key);
                res++;
            }
            return;
        }

        for (const pos of paths[index]) {
            const newCurrent = [...current, pos];
            let valid = true;

            for (let i = 0; i < newCurrent.length; i++) {
                for (let j = i + 1; j < newCurrent.length; j++) {
                    const [x1, y1] = newCurrent[i];
                    const [x2, y2] = newCurrent[j];
                    if (x1 === x2 && y1 === y2) {
                        valid = false;
                        break;
                    }
                }
                if (!valid) break;
            }

            if (valid) {
                backtrack(index + 1, newCurrent);
            }
        }
    };

    backtrack(0, []);
    return res;
};