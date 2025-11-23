var reflectLaser = function(box, laser, direction) {
    let m = box.length;
    let n = box[0].length;
    let x = laser[0];
    let y = laser[1];
    let dx = direction[0];
    let dy = direction[1];

    while (true) {
        let nextX, nextY, tX = Infinity, tY = Infinity;

        if (dx === 1) {
            tX = (n - 1 - y) / dx;
        } else if (dx === -1) {
            tX = (y - 0) / Math.abs(dx);
        }

        if (dy === 1) {
            tY = (m - 1 - x) / dy;
        } else if (dy === -1) {
            tY = (x - 0) / Math.abs(dy);
        }

        let t = Math.min(tX, tY);

        nextX = x + t * dy;
        nextY = y + t * dx;

        if (nextX === 0 || nextX === m - 1 || nextY === 0 || nextY === n - 1) {
            return [nextX, nextY];
        }

        x = nextX;
        y = nextY;

        if (tX < tY) {
            dy *= -1;
        } else {
            dx *= -1;
        }
    }
};