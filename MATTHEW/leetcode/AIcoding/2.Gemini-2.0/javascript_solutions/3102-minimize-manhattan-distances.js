var minTotalDistance = function(points) {
    let rows = [];
    let cols = [];

    for (let i = 0; i < points.length; i++) {
        rows.push(points[i][0]);
        cols.push(points[i][1]);
    }

    rows.sort((a, b) => a - b);
    cols.sort((a, b) => a - b);

    let rowMedian = rows[Math.floor(rows.length / 2)];
    let colMedian = cols[Math.floor(cols.length / 2)];

    let distance = 0;
    for (let i = 0; i < points.length; i++) {
        distance += Math.abs(points[i][0] - rowMedian) + Math.abs(points[i][1] - colMedian);
    }

    return distance;
};