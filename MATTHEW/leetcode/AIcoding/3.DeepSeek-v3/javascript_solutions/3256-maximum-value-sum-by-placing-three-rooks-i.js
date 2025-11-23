var maxValueSum = function(grid) {
    let maxSum = 0;
    const rows = grid.length;
    const cols = grid[0].length;

    for (let i1 = 0; i1 < rows; i1++) {
        for (let j1 = 0; j1 < cols; j1++) {
            for (let i2 = 0; i2 < rows; i2++) {
                for (let j2 = 0; j2 < cols; j2++) {
                    if (i1 === i2 || j1 === j2) continue;
                    for (let i3 = 0; i3 < rows; i3++) {
                        for (let j3 = 0; j3 < cols; j3++) {
                            if ((i3 === i1 || j3 === j1) || (i3 === i2 || j3 === j2)) continue;
                            const sum = grid[i1][j1] + grid[i2][j2] + grid[i3][j3];
                            if (sum > maxSum) {
                                maxSum = sum;
                            }
                        }
                    }
                }
            }
        }
    }

    return maxSum;
};