function rotateGrid(grid, k) {
    const rows = grid.length;
    const cols = grid[0].length;
    const layers = Math.min(rows, cols) / 2;

    for (let layer = 0; layer < layers; layer++) {
        const perimeter = 2 * (rows - 2 * layer) + 2 * (cols - 2 * layer) - 4;
        const effectiveK = k % perimeter;
        const currentLayer = [];

        for (let i = layer; i < rows - layer; i++) {
            currentLayer.push(grid[i][layer]);
        }
        for (let j = layer + 1; j < cols - layer; j++) {
            currentLayer.push(grid[rows - layer - 1][j]);
        }
        for (let i = rows - layer - 2; i >= layer; i--) {
            currentLayer.push(grid[i][cols - layer - 1]);
        }
        for (let j = cols - layer - 2; j > layer; j--) {
            currentLayer.push(grid[layer][j]);
        }

        const rotatedLayer = [];
        for (let i = 0; i < currentLayer.length; i++) {
            rotatedLayer[(i + effectiveK) % currentLayer.length] = currentLayer[i];
        }

        let index = 0;
        for (let i = layer; i < rows - layer; i++) {
            grid[i][layer] = rotatedLayer[index++];
        }
        for (let j = layer + 1; j < cols - layer; j++) {
            grid[rows - layer - 1][j] = rotatedLayer[index++];
        }
        for (let i = rows - layer - 2; i >= layer; i--) {
            grid[i][cols - layer - 1] = rotatedLayer[index++];
        }
        for (let j = cols - layer - 2; j > layer; j--) {
            grid[layer][j] = rotatedLayer[index++];
        }
    }

    return grid;
}