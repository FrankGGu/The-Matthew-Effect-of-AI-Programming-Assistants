var minimumMoves = function(room) {
    const m = room.length;
    const n = room[0].length;
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const visited = new Set();
    let dirty = 0;
    let startX, startY;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (room[i][j] === 'D') {
                dirty++;
            } else if (room[i][j] === 'C') {
                startX = i;
                startY = j;
            }
        }
    }

    const queue = [[startX, startY, 0, 0]];
    visited.add(`${startX},${startY},0`);

    while (queue.length > 0) {
        const [x, y, mask, steps] = queue.shift();
        if (mask === (1 << dirty) - 1) {
            return steps;
        }
        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && room[nx][ny] !== 'W') {
                let newMask = mask;
                if (room[nx][ny] === 'D') {
                    let idx = 0;
                    let tempX = 0, tempY = 0;
                    for (let i = 0; i < m; i++) {
                        for (let j = 0; j < n; j++) {
                            if (room[i][j] === 'D') {
                                if (i === nx && j === ny) {
                                    newMask |= (1 << idx);
                                }
                                idx++;
                            }
                        }
                    }
                }
                const key = `${nx},${ny},${newMask}`;
                if (!visited.has(key)) {
                    visited.add(key);
                    queue.push([nx, ny, newMask, steps + 1]);
                }
            }
        }
    }
    return -1;
};