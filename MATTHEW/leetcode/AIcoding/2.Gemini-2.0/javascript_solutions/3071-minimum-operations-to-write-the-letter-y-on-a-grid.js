var minimumOperationsToWriteY = function(grid) {
    const n = grid.length;
    const outside = new Array(3).fill(0);
    const inside = new Array(3).fill(0);
    const outsideSet = new Set();
    const insideSet = new Set();

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if ((i === j && i <= Math.floor(n / 2)) || (i + j === n - 1 && i <= Math.floor(n / 2)) || (j === Math.floor(n / 2) && i > Math.floor(n / 2))) {
                inside[grid[i][j]]++;
                insideSet.add(grid[i][j]);
            } else {
                outside[grid[i][j]]++;
                outsideSet.add(grid[i][j]);
            }
        }
    }

    let insideCount = n * 2 - 1;
    if (n % 2 === 0) {
        insideCount--;
    }

    let outsideCount = n * n - insideCount;

    let ans = Infinity;
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            if (i !== j) {
                ans = Math.min(ans, insideCount - inside[i] + outsideCount - outside[j]);
            }
        }
    }

    return ans;
};