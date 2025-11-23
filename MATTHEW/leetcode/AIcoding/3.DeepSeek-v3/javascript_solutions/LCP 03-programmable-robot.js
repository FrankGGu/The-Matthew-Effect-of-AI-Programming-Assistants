var robot = function(command, obstacles, x, y) {
    let dx = 0, dy = 0;
    for (const c of command) {
        if (c === 'U') dy++;
        else dx++;
    }

    const canReach = (x, y) => {
        let k = Math.min(Math.floor(x / dx), Math.floor(y / dy));
        let nx = k * dx, ny = k * dy;
        if (nx === x && ny === y) return true;

        for (const c of command) {
            if (nx === x && ny === y) return true;
            if (c === 'U') ny++;
            else nx++;
            if (nx > x || ny > y) return false;
        }
        return nx === x && ny === y;
    };

    if (!canReach(x, y)) return false;

    for (const [ox, oy] of obstacles) {
        if (ox <= x && oy <= y && canReach(ox, oy)) {
            return false;
        }
    }

    return true;
};