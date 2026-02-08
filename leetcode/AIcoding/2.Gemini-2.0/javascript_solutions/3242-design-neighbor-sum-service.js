class NeighborSumService {
  constructor(grid) {
    this.grid = grid;
  }

  update(row, col, val) {
    this.grid[row][col] = val;
  }

  getSum(row, col) {
    let sum = 0;
    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    for (const [dr, dc] of directions) {
      const newRow = row + dr;
      const newCol = col + dc;

      if (newRow >= 0 && newRow < this.grid.length && newCol >= 0 && newCol < this.grid[0].length) {
        sum += this.grid[newRow][newCol];
      }
    }

    return sum;
  }
}