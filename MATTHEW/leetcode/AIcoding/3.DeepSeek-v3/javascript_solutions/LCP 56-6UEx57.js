var conveyorBelt = function(matrix, start, end) {
    const m = matrix.length;
    const n = matrix[0].length;
    const dirs = {'^': [-1, 0], 'v': [1, 0], '<': [0, -1], '>': [0, 1]};
    const dist = Array.from({length: m}, () => Array(n).fill(Infinity));
    const [sx, sy] = start;
    const [ex, ey] = end;
    dist[sx][sy] = 0;
    const queue = [[sx, sy]];

    while (queue.length) {
        const [x, y] = queue.shift();
        for (const [d, [dx, dy]] of Object.entries(dirs)) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                const cost = matrix[x][y] === d ? 0 : 1;
                if (dist[nx][ny] > dist[x][y] + cost) {
                    dist[nx][ny] = dist[x][y] + cost;
                    if (cost === 0) {
                        queue.unshift([nx, ny]);
                    } else {
                        queue.push([nx, ny]);
                    }
                }
            }
        }
    }
    return dist[ex][ey];
};