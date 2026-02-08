var minAreaFreeRect = function(points) {
    const n = points.length;
    let minArea = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const p1 = points[i];
            const p2 = points[j];
            const distSq = (p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2;

            for (let k = 0; k < n; k++) {
                if (k === i || k === j) continue;
                const p3 = points[k];
                const dot1 = (p3[0] - p1[0]) * (p2[0] - p1[0]) + (p3[1] - p1[1]) * (p2[1] - p1[1]);
                if (dot1 <= 0) continue;

                const dot2 = (p3[0] - p2[0]) * (p1[0] - p2[0]) + (p3[1] - p2[1]) * (p1[1] - p2[1]);
                if (dot2 <= 0) continue;

                const p4x = p3[0] + p2[0] - p1[0];
                const p4y = p3[1] + p2[1] - p1[1];

                let found = false;
                for(let l = 0; l < n; l++){
                    if(l === i || l === j || l === k) continue;
                    if(Math.abs(points[l][0] - p4x) < 1e-6 && Math.abs(points[l][1] - p4y) < 1e-6){
                        found = true;
                        break;
                    }
                }

                if(found){
                    const side1Sq = (p3[0] - p1[0]) ** 2 + (p3[1] - p1[1]) ** 2;
                    const side2Sq = distSq;
                    const side3Sq = (p3[0] - p2[0]) ** 2 + (p3[1] - p2[1]) ** 2;

                    if(Math.abs(side1Sq + side3Sq - side2Sq) < 1e-6) {
                        const width = Math.sqrt(side1Sq);
                        const height = Math.sqrt(distSq);
                        const area = width * Math.sqrt(distSq - ( (p3[0] - p1[0]) * (p2[0] - p1[0]) + (p3[1] - p1[1]) * (p2[1] - p1[1]) ) **2 / side1Sq);
                        minArea = Math.min(minArea, area);
                    }
                }
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
};