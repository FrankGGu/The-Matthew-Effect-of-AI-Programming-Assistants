var visiblePoints = function(points, angle, location) {
    let angles = [];
    let same = 0;
    for (const [x, y] of points) {
        if (x === location[0] && y === location[1]) {
            same++;
        } else {
            let ang = Math.atan2(y - location[1], x - location[0]) * 180 / Math.PI;
            if (ang < 0) ang += 360;
            angles.push(ang);
        }
    }
    angles.sort((a, b) => a - b);
    let n = angles.length;
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
    return max + same;
};