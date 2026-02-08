var maxPointsInsideCircle = function(positions, r) {
    let n = positions.length;
    let maxPoints = 0;
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = 0; j < n; j++) {
            let dist = Math.sqrt(Math.pow(positions[i][0] - positions[j][0], 2) + Math.pow(positions[i][1] - positions[j][1], 2));
            if (dist <= r) {
                count++;
            }
        }
        maxPoints = Math.max(maxPoints, count);
    }
    return maxPoints;
};