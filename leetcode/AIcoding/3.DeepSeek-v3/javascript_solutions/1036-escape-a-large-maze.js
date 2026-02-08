var isEscapePossible = function(blocked, source, target) {
    const blocked = new Set(blocked.map(b => `${b[0]},${b[1]}`));
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const maxArea = (blocked.length * (blocked.length - 1)) / 2;

    const bfs = (start, end) => {
        const visited = new Set();
        const queue = [[start[0], start[1]]];
        visited.add(`${start[0]},${start[1]}`);
        let count = 0;

        while (queue.length > 0) {
            const [x, y] = queue.shift();
            count++;

            if (count > maxArea || (x === end[0] && y === end[1])) {
                return true;
            }

            for (const [dx, dy] of directions) {
                const nx = x + dx;
                const ny = y + dy;
                const key = `${nx},${ny}`;

                if (nx >= 0 && nx < 1e6 && ny >= 0 && ny < 1e6 && !blocked.has(key) && !visited.has(key)) {
                    visited.add(key);
                    queue.push([nx, ny]);
                }
            }
        }

        return false;
    };

    return bfs(source, target) && bfs(target, source);
};