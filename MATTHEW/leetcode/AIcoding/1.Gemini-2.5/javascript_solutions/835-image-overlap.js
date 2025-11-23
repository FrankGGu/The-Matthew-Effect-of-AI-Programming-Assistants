var largestOverlap = function(img1, img2) {
    const n = img1.length;
    const ones1 = [];
    const ones2 = [];

    for (let r = 0; r < n; r++) {
        for (let c = 0; c < n; c++) {
            if (img1[r][c] === 1) {
                ones1.push([r, c]);
            }
            if (img2[r][c] === 1) {
                ones2.push([r, c]);
            }
        }
    }

    let maxOverlap = 0;
    const translationCounts = new Map();

    for (const [r1, c1] of ones1) {
        for (const [r2, c2] of ones2) {
            const dr = r1 - r2;
            const dc = c1 - c2;
            const key = `${dr},${dc}`;
            translationCounts.set(key, (translationCounts.get(key) || 0) + 1);
            maxOverlap = Math.max(maxOverlap, translationCounts.get(key));
        }
    }

    return maxOverlap;
};