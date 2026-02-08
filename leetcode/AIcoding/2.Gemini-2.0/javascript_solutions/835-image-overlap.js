var largestOverlap = function(img1, img2) {
    const n = img1.length;
    let count = new Map();

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (img1[i][j] === 1) {
                for (let x = 0; x < n; x++) {
                    for (let y = 0; y < n; y++) {
                        if (img2[x][y] === 1) {
                            const dx = x - i;
                            const dy = y - j;
                            const key = dx + ',' + dy;
                            count.set(key, (count.get(key) || 0) + 1);
                        }
                    }
                }
            }
        }
    }

    let maxOverlap = 0;
    for (const overlap of count.values()) {
        maxOverlap = Math.max(maxOverlap, overlap);
    }

    return maxOverlap;
};