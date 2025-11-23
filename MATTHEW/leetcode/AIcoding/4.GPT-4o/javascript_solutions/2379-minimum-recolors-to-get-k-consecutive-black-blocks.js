function minimumRecolors(blocks, k) {
    let whiteCount = 0;
    for (let i = 0; i < k; i++) {
        if (blocks[i] === 'W') whiteCount++;
    }
    let minRecolors = whiteCount;

    for (let i = k; i < blocks.length; i++) {
        if (blocks[i] === 'W') whiteCount++;
        if (blocks[i - k] === 'W') whiteCount--;
        minRecolors = Math.min(minRecolors, whiteCount);
    }

    return minRecolors;
}