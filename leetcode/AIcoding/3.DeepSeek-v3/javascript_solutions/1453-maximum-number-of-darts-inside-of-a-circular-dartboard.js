var numPoints = function(points, r) {
    const n = points.length;
    let max = 1;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const [x1, y1] = points[i];
            const [x2, y2] = points[j];
            const dx = x2 - x1;
            const dy = y2 - y1;
            const d = Math.sqrt(dx * dx + dy * dy);

            if (d > 2 * r) continue;

            const midX = (x1 + x2) / 2;
            const midY = (y1 + y2) / 2;
            const h = Math.sqrt(r * r - (d / 2) * (d / 2));

            const angle = Math.atan2(dy, dx);
            const perpAngle = angle + Math.PI / 2;

            const cx1 = midX + h * Math.cos(perpAngle);
            const cy1 = midY + h * Math.sin(perpAngle);
            const cx2 = midX - h * Math.cos(perpAngle);
            const cy2 = midY - h * Math.sin(perpAngle);

            let count1 = 0, count2 = 0;
            for (const [x, y] of points) {
                const dist1 = Math.sqrt((x - cx1) * (x - cx1) + (y - cy1) * (y - cy1));
                if (dist1 <= r + 1e-6) count1++;

                const dist2 = Math.sqrt((x - cx2) * (x - cx2) + (y - cy2) * (y - cy2));
                if (dist2 <= r + 1e-6) count2++;
            }
            max = Math.max(max, count1, count2);
        }
    }

    return max;
};