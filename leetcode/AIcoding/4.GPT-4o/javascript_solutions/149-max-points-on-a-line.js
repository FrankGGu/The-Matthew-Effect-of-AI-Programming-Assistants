var maxPoints = function(points) {
    if (points.length < 2) return points.length;

    let max = 0;

    for (let i = 0; i < points.length; i++) {
        let slopeCount = new Map();
        let samePoint = 1;

        for (let j = i + 1; j < points.length; j++) {
            const dx = points[j][0] - points[i][0];
            const dy = points[j][1] - points[i][1];

            if (dx === 0 && dy === 0) {
                samePoint++;
                continue;
            }

            const gcd = getGCD(dy, dx);
            const slope = `${dy / gcd}/${dx / gcd}`;
            slopeCount.set(slope, (slopeCount.get(slope) || 0) + 1);
        }

        let localMax = samePoint;
        for (let count of slopeCount.values()) {
            localMax = Math.max(localMax, count + samePoint);
        }

        max = Math.max(max, localMax);
    }

    return max;
};

function getGCD(a, b) {
    if (b === 0) return Math.abs(a);
    return getGCD(b, a % b);
}