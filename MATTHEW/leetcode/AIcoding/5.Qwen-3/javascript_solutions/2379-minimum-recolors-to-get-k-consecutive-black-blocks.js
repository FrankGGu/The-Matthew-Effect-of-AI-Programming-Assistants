function minimumRecolors(blocks, k) {
    let minRecolors = Infinity;
    let count = 0;

    for (let i = 0; i < blocks.length; i++) {
        if (blocks[i] === 'b') {
            count++;
        }

        if (i >= k) {
            if (blocks[i - k] === 'b') {
                count--;
            }
        }

        if (i >= k - 1) {
            minRecolors = Math.min(minRecolors, k - count);
        }
    }

    return minRecolors;
}