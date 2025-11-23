var minimumLines = function(coordinates) {
    if (coordinates.length <= 1) return 0;
    let count = 1;
    for (let i = 1; i < coordinates.length - 1; i++) {
        const [x1, y1] = coordinates[i - 1];
        const [x2, y2] = coordinates[i];
        const [x3, y3] = coordinates[i + 1];
        if ((y2 - y1) * (x3 - x2) !== (y3 - y2) * (x2 - x1)) {
            count++;
        }
    }
    return count;
};