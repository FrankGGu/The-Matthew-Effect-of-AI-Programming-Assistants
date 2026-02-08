var minimumMoves = function(grid) {
    const stones = [];
    const holes = [];
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            if (grid[i][j] > 1) {
                for (let k = 0; k < grid[i][j] - 1; k++) {
                    stones.push([i, j]);
                }
            } else if (grid[i][j] === 0) {
                holes.push([i, j]);
            }
        }
    }

    const permute = (arr, start, result) => {
        if (start === arr.length - 1) {
            result.push([...arr]);
            return;
        }
        for (let i = start; i < arr.length; i++) {
            [arr[start], arr[i]] = [arr[i], arr[start]];
            permute(arr, start + 1, result);
            [arr[start], arr[i]] = [arr[i], arr[start]];
        }
    };

    const permutations = [];
    permute(stones, 0, permutations);

    let minMoves = Infinity;
    for (const perm of permutations) {
        let total = 0;
        for (let i = 0; i < holes.length; i++) {
            const [x1, y1] = holes[i];
            const [x2, y2] = perm[i];
            total += Math.abs(x1 - x2) + Math.abs(y1 - y2);
        }
        if (total < minMoves) {
            minMoves = total;
        }
    }

    return minMoves;
};