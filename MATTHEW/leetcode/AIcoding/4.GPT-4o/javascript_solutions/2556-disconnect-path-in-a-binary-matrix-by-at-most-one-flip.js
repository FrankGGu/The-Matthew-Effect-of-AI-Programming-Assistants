var canDisconnect = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    const isValid = (r, c) => r >= 0 && r < rows && c >= 0 && c < cols;

    const bfs = (start, flipAllowed) => {
        const queue = [start];
        const visited = new Set();
        visited.add(start.join(','));

        while (queue.length) {
            const [r, c] = queue.shift();
            if (grid[r][c] === 0 && flipAllowed) return true;

            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;

                if (isValid(nr, nc) && !visited.has(`${nr},${nc}`)) {
                    if (grid[nr][nc] === 1) {
                        if (flipAllowed) {
                            visited.add(`${nr},${nc}`);
                            queue.push([nr, nc]);
                        }
                    } else {
                        visited.add(`${nr},${nc}`);
                        queue.push([nr, nc]);
                    }
                }
            }
        }
        return false;
    };

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (grid[r][c] === 1) {
                if (bfs([r, c], true)) return true;
                return bfs([r, c], false);
            }
        }
    }
    return false;
};