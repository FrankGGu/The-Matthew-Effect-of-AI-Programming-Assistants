var isPathCrossing = function(path) {
    let visited = new Set();
    let x = 0, y = 0;
    visited.add(`${x},${y}`);

    for (let dir of path) {
        switch (dir) {
            case 'N': y++; break;
            case 'S': y--; break;
            case 'E': x++; break;
            case 'W': x--; break;
        }
        let key = `${x},${y}`;
        if (visited.has(key)) {
            return true;
        }
        visited.add(key);
    }
    return false;
};