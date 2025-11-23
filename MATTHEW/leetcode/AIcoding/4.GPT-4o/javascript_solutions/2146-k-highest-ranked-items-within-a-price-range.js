function highestRankedKItems(grid, pricing, k) {
    const [low, high] = pricing;
    const items = [];
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const rows = grid.length;
    const cols = grid[0].length;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] >= low && grid[i][j] <= high) {
                items.push([grid[i][j], i, j]);
            }
        }
    }

    items.sort((a, b) => {
        if (a[0] !== b[0]) return a[0] - b[0];
        if (a[1] !== b[1]) return a[1] - b[1];
        return a[2] - b[2];
    });

    return items.slice(0, k).map(item => [item[1], item[2]]);
}