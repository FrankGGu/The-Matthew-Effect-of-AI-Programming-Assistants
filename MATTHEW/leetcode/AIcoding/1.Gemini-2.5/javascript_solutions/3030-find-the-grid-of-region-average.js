var findTheGridOfRegionAverage = function(grid, threshold) {
    const m = grid.length;
    const n = grid[0].length;

    const sumOfAverages = Array(m).fill(0).map(() => Array(n).fill(0));
    const countOfRegions = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let rStart = 0; rStart <= m - 3; rStart++) {
        for (let cStart = 0; cStart <= n - 3; cStart++) {
            let isValidRegion = true;
            let regionSum = 0;

            for (let r = rStart; r <= rStart + 2; r++) {
                for (let c = cStart; c <= cStart + 2; c++) {
                    regionSum += grid[r][c];

                    if (c < cStart + 2) {
                        if (Math.abs(grid[r][c] - grid[r][c+1]) > threshold) {
                            isValidRegion = false;
                            break;
                        }
                    }
                    if (r < rStart + 2) {
                        if (Math.abs(grid[r][c] - grid[r+1][c]) > threshold) {
                            isValidRegion = false;
                            break;
                        }
                    }
                }
                if (!isValidRegion) {
                    break;
                }
            }

            if (isValidRegion) {
                const regionAverage = Math.floor(regionSum / 9);

                for (let r = rStart; r <= rStart + 2; r++) {
                    for (let c = cStart; c <= cStart + 2; c++) {
                        sumOfAverages[r][c] += regionAverage;
                        countOfRegions[r][c] += 1;
                    }
                }
            }
        }
    }

    const resultGrid = Array(m).fill(0).map(() => Array(n).fill(0));
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (countOfRegions[r][c] > 0) {
                resultGrid[r][c] = Math.floor(sumOfAverages[r][c] / countOfRegions[r][c]);
            } else {
                resultGrid[r][c] = grid[r][c];
            }
        }
    }

    return resultGrid;
};