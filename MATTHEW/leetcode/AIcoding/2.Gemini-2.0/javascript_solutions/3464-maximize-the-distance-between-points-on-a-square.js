var maxPointsOnALine = function(p) {
    const n = p.length;
    if (n <= 2) return n;

    let maxPoints = 0;
    for (let i = 0; i < n; i++) {
        const slopeCounts = new Map();
        let duplicates = 1;
        let verticalLines = 0;

        for (let j = i + 1; j < n; j++) {
            if (p[i][0] === p[j][0] && p[i][1] === p[j][1]) {
                duplicates++;
            } else if (p[i][0] === p[j][0]) {
                verticalLines++;
            } else {
                const dy = p[j][1] - p[i][1];
                const dx = p[j][0] - p[i][0];
                const slope = dy / dx;

                if (slopeCounts.has(slope)) {
                    slopeCounts.set(slope, slopeCounts.get(slope) + 1);
                } else {
                    slopeCounts.set(slope, 1);
                }
            }
        }

        let currentMax = duplicates;
        slopeCounts.forEach(count => {
            currentMax = Math.max(currentMax, count + duplicates);
        });

        currentMax = Math.max(currentMax, verticalLines + duplicates);
        maxPoints = Math.max(maxPoints, currentMax);
    }

    return maxPoints;
};