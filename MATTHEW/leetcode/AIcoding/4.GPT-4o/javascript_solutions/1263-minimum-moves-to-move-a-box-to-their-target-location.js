var minPushBox = function(box, player, target, grid) {
    const m = grid.length, n = grid[0].length;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const isValid = (x, y) => x >= 0 && x < m && y >= 0 && y < n && grid[x][y] !== '#';

    const bfs = (bx, by, px, py) => {
        const queue = [[bx, by, px, py]];
        const visited = new Set();
        visited.add(`${bx},${by},${px},${py}`);
        let moves = 0;

        while (queue.length) {
            const size = queue.length;
            for (let i = 0; i < size; i++) {
                const [bx, by, px, py] = queue.shift();
                if (bx === target[0] && by === target[1]) return moves;

                for (const [dx, dy] of directions) {
                    const nbx = bx + dx, nby = by + dy;
                    const npx = bx - dx, npy = by - dy;
                    if (isValid(nbx, nby) && isValid(npx, npy) && (npx !== px || npy !== py)) {
                        const key = `${nbx},${nby},${bx},${by}`;
                        if (!visited.has(key)) {
                            visited.add(key);
                            queue.push([nbx, nby, bx, by]);
                        }
                    }
                }
            }
            moves++;
        }
        return -1;
    };

    return bfs(box[0], box[1], player[0], player[1]);
};