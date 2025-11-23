var isEscapePossible = function(robots, target, maze) {
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const m = maze.length;
    const n = maze[0].length;

    const bfs = (start, end, visited) => {
        const queue = [start];
        const seen = new Set([`${start[0]},${start[1]}`]);
        while (queue.length > 0) {
            const [x, y] = queue.shift();
            if (x === end[0] && y === end[1]) return true;
            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && ny >= 0 && nx < m && ny < n && !visited.has(`${nx},${ny}`) && maze[nx][ny] === 0) {
                    const key = `${nx},${ny}`;
                    if (!seen.has(key)) {
                        seen.add(key);
                        queue.push([nx, ny]);
                    }
                }
            }
        }
        return false;
    };

    const visited1 = new Set();
    const visited2 = new Set();
    for (let i = 0; i < robots.length; i++) {
        const [x, y] = robots[i];
        visited1.add(`${x},${y}`);
    }
    for (let i = 0; i < robots.length; i++) {
        const [x, y] = robots[i];
        visited2.add(`${x},${y}`);
    }

    const start = robots[0];
    const end = target;
    return bfs(start, end, visited1) && bfs(end, start, visited2);
};