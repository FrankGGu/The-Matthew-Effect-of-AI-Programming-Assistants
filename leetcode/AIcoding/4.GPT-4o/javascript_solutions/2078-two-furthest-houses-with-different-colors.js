function maxDistance(colors) {
    let n = colors.length;
    let leftColor = colors[0];
    let rightColor = colors[n - 1];

    for (let i = 0; i < n; i++) {
        if (colors[i] !== leftColor) {
            return i;
        }
        if (colors[n - 1 - i] !== rightColor) {
            return n - 1 - i;
        }
    }
    return 0;
}