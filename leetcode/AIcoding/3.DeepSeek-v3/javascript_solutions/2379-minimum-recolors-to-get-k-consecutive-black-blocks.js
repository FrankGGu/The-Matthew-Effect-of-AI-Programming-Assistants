var minimumRecolors = function(blocks, k) {
    let minRecolors = Infinity;
    let whiteCount = 0;

    for (let i = 0; i < blocks.length; i++) {
        if (blocks[i] === 'W') {
            whiteCount++;
        }

        if (i >= k - 1) {
            if (i >= k) {
                if (blocks[i - k] === 'W') {
                    whiteCount--;
                }
            }
            minRecolors = Math.min(minRecolors, whiteCount);
        }
    }

    return minRecolors;
};