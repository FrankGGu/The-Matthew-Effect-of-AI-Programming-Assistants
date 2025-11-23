function isPathCrossing(path) {
    const visited = new Set();
    visited.add("0,0");
    let x = 0, y = 0;
    for (let i = 0; i < path.length; i++) {
        switch (path[i]) {
            case 'n':
                y++;
                break;
            case 's':
                y--;
                break;
            case 'e':
                x++;
                break;
            case 'w':
                x--;
                break;
        }
        const key = `${x},${y}`;
        if (visited.has(key)) {
            return true;
        }
        visited.add(key);
    }
    return false;
}