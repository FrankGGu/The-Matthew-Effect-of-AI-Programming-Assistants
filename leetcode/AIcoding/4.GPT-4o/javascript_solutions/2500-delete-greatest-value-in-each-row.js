function deleteGreatestValue(grid) {
    let maxSum = 0;
    for (let col = 0; col < grid[0].length; col++) {
        let maxInCol = 0;
        for (let row = 0; row < grid.length; row++) {
            maxInCol = Math.max(maxInCol, grid[row][col]);
        }
        maxSum += maxInCol;
    }
    return maxSum;
}