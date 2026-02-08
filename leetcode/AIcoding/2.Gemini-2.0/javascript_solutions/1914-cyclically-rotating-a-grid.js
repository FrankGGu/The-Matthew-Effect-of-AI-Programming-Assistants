var rotateGrid = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    let layers = Math.min(m, n) / 2;

    for (let l = 0; l < layers; l++) {
        let elements = [];
        let rows = m - 2 * l;
        let cols = n - 2 * l;

        // Top
        for (let j = l; j < n - l; j++) {
            elements.push(grid[l][j]);
        }

        // Right
        for (let i = l + 1; i < m - l; i++) {
            elements.push(grid[i][n - l - 1]);
        }

        // Bottom
        for (let j = n - l - 2; j >= l; j--) {
            elements.push(grid[m - l - 1][j]);
        }

        // Left
        for (let i = m - l - 2; i > l; i--) {
            elements.push(grid[i][l]);
        }

        let rotations = k % elements.length;

        for (let i = 0; i < rotations; i++) {
            elements.unshift(elements.pop());
        }

        let index = 0;

        // Top
        for (let j = l; j < n - l; j++) {
            grid[l][j] = elements[index++];
        }

        // Right
        for (let i = l + 1; i < m - l; i++) {
            grid[i][n - l - 1] = elements[index++];
        }

        // Bottom
        for (let j = n - l - 2; j >= l; j--) {
            grid[m - l - 1][j] = elements[index++];
        }

        // Left
        for (let i = m - l - 2; i > l; i--) {
            grid[i][l] = elements[index++];
        }
    }

    return grid;
};