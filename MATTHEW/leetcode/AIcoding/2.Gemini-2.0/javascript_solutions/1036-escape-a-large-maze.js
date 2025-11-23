var isEscapePossible = function(blocked, source, target) {
    const blockedSet = new Set(blocked.map(b => b[0] * 1000000 + b[1]));
    const MAX = 1000000;

    if (blocked.length < 2) return true;

    const bfs = (start, end) => {
        let visited = new Set();
        let queue = [start];
        visited.add(start[0] * 1000000 + start[1]);
        let count = 0;

        while (queue.length > 0) {
            let [x, y] = queue.shift();
            count++;

            if (x === end[0] && y === end[1]) return true;
            if (count > 20000) return true;

            let directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];
            for (let [dx, dy] of directions) {
                let nx = x + dx;
                let ny = y + dy;

                if (nx >= 0 && nx < MAX && ny >= 0 && ny < MAX && !blockedSet.has(nx * 1000000 + ny) && !visited.has(nx * 1000000 + ny)) {
                    queue.push([nx, ny]);
                    visited.add(nx * 1000000 + ny);
                }
            }
        }

        return false;
    };

    return bfs(source, target) && bfs(target, source);
};