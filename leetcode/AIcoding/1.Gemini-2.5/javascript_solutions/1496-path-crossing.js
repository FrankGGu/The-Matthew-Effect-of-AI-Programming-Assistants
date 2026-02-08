var isPathCrossing = function(path) {
    let x = 0;
    let y = 0;
    const visited = new Set();
    visited.add("0,0");

    for (let i = 0; i < path.length; i++) {
        const direction = path[i];
        if (direction === 'N') {
            y++;
        } else if (direction === 'S') {
            y--;
        } else if (direction === 'E') {
            x++;
        } else if (direction === 'W') {
            x--;
        }

        const currentPos = `${x},${y}`;
        if (visited.has(currentPos)) {
            return true;
        }
        visited.add(currentPos);
    }

    return false;
};