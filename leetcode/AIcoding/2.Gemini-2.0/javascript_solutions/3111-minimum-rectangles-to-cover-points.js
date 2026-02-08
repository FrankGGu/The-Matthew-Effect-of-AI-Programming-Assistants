var minAreaRect = function(points) {
    let n = points.length;
    let minArea = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let x1 = points[i][0];
            let y1 = points[i][1];
            let x2 = points[j][0];
            let y2 = points[j][1];

            if (x1 === x2 || y1 === y2) continue;

            let p3Exists = false;
            let p4Exists = false;

            for (let k = 0; k < n; k++) {
                if (k !== i && k !== j) {
                    if (points[k][0] === x1 && points[k][1] === y2) {
                        p3Exists = true;
                    }
                    if (points[k][0] === x2 && points[k][1] === y1) {
                        p4Exists = true;
                    }
                }
            }

            if (p3Exists && p4Exists) {
                let area = Math.abs(x1 - x2) * Math.abs(y1 - y2);
                minArea = Math.min(minArea, area);
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
};