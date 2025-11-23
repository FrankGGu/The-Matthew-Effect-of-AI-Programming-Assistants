var largestOverlap = function(img1, img2) {
    const n = img1.length;
    const count = new Map();
    let maxOverlap = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (img1[i][j] === 1) {
                for (let k = 0; k < n; k++) {
                    for (let l = 0; l < n; l++) {
                        if (img2[k][l] === 1) {
                            const key = `${i - k},${j - l}`;
                            count.set(key, (count.get(key) || 0) + 1);
                            maxOverlap = Math.max(maxOverlap, count.get(key));
                        }
                    }
                }
            }
        }
    }

    return maxOverlap;
};