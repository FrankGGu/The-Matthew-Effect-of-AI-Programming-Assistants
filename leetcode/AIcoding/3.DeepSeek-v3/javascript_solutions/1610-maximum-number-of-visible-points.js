var visiblePoints = function(points, angle, location) {
    let same = 0;
    const angles = [];
    const [x0, y0] = location;

    for (const [x, y] of points) {
        if (x === x0 && y === y0) {
            same++;
        } else {
            const rad = Math.atan2(y - y0, x - x0);
            const deg = rad * 180 / Math.PI;
            angles.push(deg);
        }
    }

    angles.sort((a, b) => a - b);
    const n = angles.length;
    for (let i = 0; i < n; i++) {
        angles.push(angles[i] + 360);
    }

    let max = 0;
    let left = 0;
    for (let right = 0; right < angles.length; right++) {
        while (angles[right] - angles[left] > angle + 1e-9) {
            left++;
        }
        max = Math.max(max, right - left + 1);
    }

    return max + same;
};