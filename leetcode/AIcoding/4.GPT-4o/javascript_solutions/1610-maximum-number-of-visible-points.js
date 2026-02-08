var visiblePoints = function(points, angle, location) {
    const n = points.length;
    const angles = [];

    for (const [x, y] of points) {
        const dx = x - location[0];
        const dy = y - location[1];
        const theta = Math.atan2(dy, dx) * (180 / Math.PI);
        angles.push(theta < 0 ? theta + 360 : theta);
    }

    angles.sort((a, b) => a - b);
    const extendedAngles = [...angles, ...angles.map(a => a + 360)];

    let maxVisible = 0;
    const rad = angle;

    for (let i = 0, j = 0; i < extendedAngles.length; i++) {
        while (j < extendedAngles.length && extendedAngles[j] - extendedAngles[i] <= rad) {
            j++;
        }
        maxVisible = Math.max(maxVisible, j - i);
    }

    return maxVisible;
};