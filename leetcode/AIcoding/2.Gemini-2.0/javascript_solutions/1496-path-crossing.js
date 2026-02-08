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
        } else {
            x--;
        }

        const coordinate = `${x},${y}`;
        if (visited.has(coordinate)) {
            return true;
        }
        visited.add(coordinate);
    }

    return false;
};