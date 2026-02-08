function visiblePoints(points, angle, location) {
    const [x0, y0] = location;
    const angles = [];
    let count = 0;

    for (const [x, y] of points) {
        if (x === x0 && y === y0) {
            count++;
            continue;
        }
        const dx = x - x0;
        const dy = y - y0;
        const rad = Math.atan2(dy, dx);
        const deg = rad * 180 / Math.PI;
        angles.push(deg);
    }

    angles.sort((a, b) => a - b);

    const n = angles.length;
    for (let i = 0; i < n; i++) {
        angles.push(angles[i] + 360);
    }

    let max = 0;
    let left = 0;

    for (let right = 0; right < angles.length; right++) {
        while (angles[right] - angles[left] > angle) {
            left++;
        }
        max = Math.max(max, right - left + 1);
    }

    return count + max;
}