var numMagicSquaresInside = function(grid) {
    let count = 0;
    for (let i = 0; i <= grid.length - 3; i++) {
        for (let j = 0; j <= grid[0].length - 3; j++) {
            if (isMagicSquare(grid, i, j)) {
                count++;
            }
        }
    }
    return count;
};

function isMagicSquare(grid, x, y) {
    const set = new Set();
    for (let i = x; i < x + 3; i++) {
        for (let j = y; j < y + 3; j++) {
            if (grid[i][j] < 1 || grid[i][j] > 9 || set.has(grid[i][j])) {
                return false;
            }
            set.add(grid[i][j]);
        }
    }

    const row1 = grid[x][y] + grid[x][y+1] + grid[x][y+2];
    const row2 = grid[x+1][y] + grid[x+1][y+1] + grid[x+1][y+2];
    const row3 = grid[x+2][y] + grid[x+2][y+1] + grid[x+2][y+2];

    const col1 = grid[x][y] + grid[x+1][y] + grid[x+2][y];
    const col2 = grid[x][y+1] + grid[x+1][y+1] + grid[x+2][y+1];
    const col3 = grid[x][y+2] + grid[x+1][y+2] + grid[x+2][y+2];

    const diag1 = grid[x][y] + grid[x+1][y+1] + grid[x+2][y+2];
    const diag2 = grid[x][y+2] + grid[x+1][y+1] + grid[x+2][y];

    return row1 === row2 && row2 === row3 && 
           row3 === col1 && col1 === col2 && 
           col2 === col3 && col3 === diag1 && 
           diag1 === diag2;
}