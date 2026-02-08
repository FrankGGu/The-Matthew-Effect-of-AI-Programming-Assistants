var maxPoints = function(points) {
    if (points.length <= 2) return points.length;

    let max = 0;

    for (let i = 0; i < points.length; i++) {
        const slopes = new Map();
        let same = 1;
        let localMax = 0;

        for (let j = i + 1; j < points.length; j++) {
            const [x1, y1] = points[i];
            const [x2, y2] = points[j];

            if (x1 === x2 && y1 === y2) {
                same++;
                continue;
            }

            let dx = x2 - x1;
            let dy = y2 - y1;
            let g = gcd(dx, dy);
            let slope = `${dx / g},${dy / g}`;

            slopes.set(slope, (slopes.get(slope) || 0) + 1);
            localMax = Math.max(localMax, slopes.get(slope));
        }

        max = Math.max(max, localMax + same);
    }

    return max;
};

function gcd(a, b) {
    return b === 0 ? a : gcd(b, a % b);
}