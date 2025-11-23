var maxDistance = function(colors) {
    let max = 0;
    const n = colors.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (colors[i] !== colors[j]) {
                max = Math.max(max, j - i);
            }
        }
    }
    return max;
};