var hasValidPath = function(grid) {
    const m = grid.length, n = grid[0].length;
    const directions = {
        1: [[0, 1], [1, 0]],
        2: [[0, -1], [1, 0]],
        3: [[1, 0], [0, 1]],
        4: [[1, 0], [0, -1]],
        5: [[0, 1], [-1, 0]],
        6: [[0, -1], [-1, 0]]
    };

    const isValid = (x, y, nx, ny) => {
        for (let [dx, dy] of directions[grid[x][y]]) {
            if (x + dx === nx && y + dy === ny) return true;
        }
        return false;
    };

    const queue = [[0, 0]];
    const visited = new Set();
    visited.add('0,0');

    while (queue.length) {
        const [x, y] = queue.shift();
        if (x === m - 1 && y === n - 1) return true;

        for (let [dx, dy] of directions[grid[x][y]]) {
            const nx = x + dx, ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited.has(`${nx},${ny}`) && isValid(x, y, nx, ny)) {
                visited.add(`${nx},${ny}`);
                queue.push([nx, ny]);
            }
        }
    }

    return false;
};