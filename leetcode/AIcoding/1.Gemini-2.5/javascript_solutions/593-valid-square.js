var validSquare = function(p1, p2, p3, p4) {
    function distSq(point1, point2) {
        return (point1[0] - point2[0]) * (point1[0] - point2[0]) + 
               (point1[1] - point2[1]) * (point1[1] - point2[1]);
    }

    const points = [p1, p2, p3, p4];
    const distCounts = new Map();

    for (let i = 0; i < 4; i++) {
        for (let j = i + 1; j < 4; j++) {
            const d = distSq(points[i], points[j]);
            if (d === 0) {
                return false;
            }
            distCounts.set(d, (distCounts.get(d) || 0) + 1);
        }
    }

    if (distCounts.size !== 2) {
        return false;
    }

    const keys = Array.from(distCounts.keys());
    const d1 = keys[0];
    const d2 = keys[1];

    const count1 = distCounts.get(d1);
    const count2 = distCounts.get(d2);

    if (!((count1 === 4 && count2 === 2) || (count1 === 2 && count2 === 4))) {
        return false;
    }

    const sideSq = (count1 === 4) ? d1 : d2;
    const diagSq = (count1 === 2) ? d1 : d2;

    return diagSq === 2 * sideSq;
};