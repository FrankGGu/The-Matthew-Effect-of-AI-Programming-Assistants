var maxPoints = function(points) {
    if (points.length <= 1) return points.length;

    let max = 0;

    for (let i = 0; i < points.length; i++) {
        let map = {};
        let currentMax = 0;
        let duplicate = 0;

        for (let j = i + 1; j < points.length; j++) {
            let x1 = points[i][0], y1 = points[i][1];
            let x2 = points[j][0], y2 = points[j][1];

            if (x1 === x2 && y1 === y2) {
                duplicate++;
                continue;
            }

            let gcd = greatestCommonDivisor(Math.abs(x1 - x2), Math.abs(y1 - y2));
            let dx = (x1 - x2) / gcd;
            let dy = (y1 - y2) / gcd;

            let key = dx + "," + dy;

            if (!map[key]) {
                map[key] = 1;
            } else {
                map[key]++;
            }

            currentMax = Math.max(currentMax, map[key]);
        }

        max = Math.max(max, currentMax + duplicate + 1);
    }

    return max;
};

function greatestCommonDivisor(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}