var minimumRecolors = function(blocks, k) {
    let minRecolors = Infinity;
    for (let i = 0; i <= blocks.length - k; i++) {
        let recolors = 0;
        for (let j = i; j < i + k; j++) {
            if (blocks[j] === 'W') {
                recolors++;
            }
        }
        minRecolors = Math.min(minRecolors, recolors);
    }
    return minRecolors;
};