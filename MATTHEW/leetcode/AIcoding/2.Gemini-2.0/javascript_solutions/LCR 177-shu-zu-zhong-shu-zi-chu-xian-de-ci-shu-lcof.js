var colorfulSet = function(colors) {
    const n = colors.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (Math.abs(colors[i] - colors[j]) > 1) {
                count++;
            }
        }
    }

    return count;
};