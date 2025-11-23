var findMissingAndRepeatedValues = function(grid) {
    const n = grid.length;
    const total = n * n;
    const count = new Array(total + 1).fill(0);
    let repeated = -1;
    let missing = -1;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            const num = grid[i][j];
            count[num]++;
            if (count[num] === 2) {
                repeated = num;
            }
        }
    }

    for (let i = 1; i <= total; i++) {
        if (count[i] === 0) {
            missing = i;
            break;
        }
    }

    return [repeated, missing];
};