var findMissingAndRepeatedValues = function(grid) {
    const n = grid.length;
    const total = n * n;
    const counts = new Array(total + 1).fill(0);
    let repeated = -1;
    let sum = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            const num = grid[i][j];
            counts[num]++;
            if (counts[num] > 1) {
                repeated = num;
            }
            sum += num;
        }
    }

    const expectedSum = total * (total + 1) / 2;
    const missing = expectedSum - (sum - repeated);

    return [repeated, missing];
};