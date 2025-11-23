var guardCastle = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const INF = 1e9;
    let monsters = [];
    let castle = null;
    let player = null;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 'S') {
                monsters.push([i, j]);
            } else if (grid[i][j] === 'C') {
                castle = [i, j];
            } else if (grid[i][j] === 'P') {
                player = [i, j];
            }
        }
    }

    if (!castle || !player) return -1;

    const bfs = (start, target) => {
        const dist = Array.from({ length: m }, () => Array(n).fill(INF));
        const q = [];
        dist[start[0]][start[1]] = 0;
        q.push(start);

        while (q.length) {
            const [x, y] = q.shift();
            if (x === target[0] && y === target[1]) {
                return dist[x][y];
            }
            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] !== '#') {
                    if (dist[nx][ny] > dist[x][y] + 1) {
                        dist[nx][ny] = dist[x][y] + 1;
                        q.push([nx, ny]);
                    }
                }
            }
        }
        return INF;
    };

    const playerDist = bfs(player, castle);
    if (playerDist === INF) return -1;

    let minMonsterDist = INF;
    for (const monster of monsters) {
        const dist = bfs(monster, castle);
        if (dist < minMonsterDist) {
            minMonsterDist = dist;
        }
    }

    if (minMonsterDist <= playerDist) return -1;

    let minBarriers = INF;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '.') {
                grid[i][j] = '#';
                let newPlayerDist = bfs(player, castle);
                let valid = true;
                if (newPlayerDist === INF) {
                    valid = false;
                } else {
                    for (const monster of monsters) {
                        const dist = bfs(monster, castle);
                        if (dist <= newPlayerDist) {
                            valid = false;
                            break;
                        }
                    }
                }
                if (valid && newPlayerDist < minBarriers) {
                    minBarriers = newPlayerDist;
                }
                grid[i][j] = '.';
            }
        }
    }

    return minBarriers === INF ? -1 : minBarriers - playerDist;
};