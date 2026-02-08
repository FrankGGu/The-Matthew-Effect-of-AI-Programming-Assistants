class Solution {
    maxRectangle(points) {
        const pointSet = new Set(points.map(point => point.join(',')));
        const n = points.length;
        let maxArea = 0;

        for (let i = 0; i < n; i++) {
            for (let j = i + 1; j < n; j++) {
                if (points[i][0] !== points[j][0] && points[i][1] !== points[j][1]) {
                    const p1 = [points[i][0], points[j][1]];
                    const p2 = [points[j][0], points[i][1]];

                    if (pointSet.has(p1.join(',')) && pointSet.has(p2.join(','))) {
                        const area = Math.abs(points[i][0] - points[j][0]) * Math.abs(points[i][1] - points[j][1]);
                        maxArea = Math.max(maxArea, area);
                    }
                }
            }
        }
        return maxArea;
    }
}