var numPoints = function(points, r) {
    const n = points.length;
    let ans = 1;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const x1 = points[i][0];
            const y1 = points[i][1];
            const x2 = points[j][0];
            const y2 = points[j][1];

            const dist = Math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2);

            if (dist > 2 * r) continue;

            const midX = (x1 + x2) / 2;
            const midY = (y1 + y2) / 2;
            const d = Math.sqrt(r * r - (dist / 2) ** 2);

            const dx = (y2 - y1) * d / dist;
            const dy = (x1 - x2) * d / dist;

            const centerX1 = midX + dx;
            const centerY1 = midY + dy;
            const centerX2 = midX - dx;
            const centerY2 = midY - dy;

            let count1 = 0;
            let count2 = 0;

            for (let k = 0; k < n; k++) {
                const x = points[k][0];
                const y = points[k][1];

                const dist1 = Math.sqrt((x - centerX1) ** 2 + (y - centerY1) ** 2);
                const dist2 = Math.sqrt((x - centerX2) ** 2 + (y - centerY2) ** 2);

                if (dist1 <= r) count1++;
                if (dist2 <= r) count2++;
            }

            ans = Math.max(ans, count1, count2);
        }
    }

    return ans;
};