var isPathCrossing = function(path) {
    const visited = new Set();
    let x = 0, y = 0;
    visited.add(`${x},${y}`);

    for (const direction of path) {
        if (direction === 'N') y++;
        else if (direction === 'S') y--;
        else if (direction === 'E') x++;
        else if (direction === 'W') x--;

        const pos = `${x},${y}`;
        if (visited.has(pos)) return true;
        visited.add(pos);
    }

    return false;
};