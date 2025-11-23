var rotateGrid = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const layers = Math.min(m, n) / 2;

    for (let l = 0; l < layers; l++) {
        const elements = [];
        const rows = m - 2 * l;
        const cols = n - 2 * l;
        const total = 2 * (rows + cols) - 4;

        let r = l, c = l;
        for (let i = 0; i < cols - 1; i++) {
            elements.push(grid[r][c]);
            c++;
        }
        for (let i = 0; i < rows - 1; i++) {
            elements.push(grid[r][c]);
            r++;
        }
        for (let i = 0; i < cols - 1; i++) {
            elements.push(grid[r][c]);
            c--;
        }
        for (let i = 0; i < rows - 1; i++) {
            elements.push(grid[r][c]);
            r--;
        }

        const rotated = [];
        const shift = k % total;
        for (let i = 0; i < total; i++) {
            rotated.push(elements[(i + shift) % total]);
        }

        r = l, c = l;
        let idx = 0;
        for (let i = 0; i < cols - 1; i++) {
            grid[r][c] = rotated[idx++];
            c++;
        }
        for (let i = 0; i < rows - 1; i++) {
            grid[r][c] = rotated[idx++];
            r++;
        }
        for (let i = 0; i < cols - 1; i++) {
            grid[r][c] = rotated[idx++];
            c--;
        }
        for (let i = 0; i < rows - 1; i++) {
            grid[r][c] = rotated[idx++];
            r--;
        }
    }

    return grid;
};