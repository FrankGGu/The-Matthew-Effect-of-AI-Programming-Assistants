function findColorPairs(colors) {
    const colorSet = new Set(colors);
    let count = 0;
    for (const color of colors) {
        if (colorSet.has(color + 's') || colorSet.has(color + 'S')) {
            count++;
        }
    }
    return count;
}