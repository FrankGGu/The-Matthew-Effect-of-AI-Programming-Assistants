var maxVisiblePoints = function(points, angle, location) {
    let baseCount = 0;
    const angles = [];
    const px = location[0];
    const py = location[1];

    for (const point of points) {
        const x = point[0];
        const y = point[1];

        if (x === px && y === py) {
            baseCount++;
        } else {
            const angleRad = Math.atan2(y - py, x - px);
            let angleDeg = angleRad * 180 / Math.PI;
            if (angleDeg < 0) {
                angleDeg += 360;
            }
            angles.push(angleDeg);
        }
    }

    angles.sort((a, b) => a - b);

    const n = angles.length;
    if (n === 0) {
        return baseCount;
    }

    for (let i = 0; i < n; i++) {
        angles.push(angles[i] + 360);
    }

    let maxVisible = 0;
    let left = 0;

    for (let right = 0; right < angles.length; right++) {
        while (angles[right] - angles[left] > angle) {
            left++;
        }
        maxVisible = Math.max(maxVisible, right - left + 1);
    }

    return maxVisible + baseCount;
};