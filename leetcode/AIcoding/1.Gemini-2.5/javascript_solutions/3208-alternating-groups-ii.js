var alternatingGroups = function(colors, k) {
    const n = colors.length;

    if (k === 1) {
        return n;
    }

    const extendedColors = new Array(n + k - 1);
    for (let i = 0; i < n + k - 1; i++) {
        extendedColors[i] = colors[i % n];
    }

    let count = 0;
    let alternatingPairs = 0;

    for (let i = 0; i < k - 1; i++) {
        if (extendedColors[i] !== extendedColors[i + 1]) {
            alternatingPairs++;
        }
    }

    if (alternatingPairs === k - 1) {
        count++;
    }

    for (let i = 1; i < n; i++) {
        if (extendedColors[i - 1] !== extendedColors[i]) {
            alternatingPairs--;
        }

        if (extendedColors[i + k - 2] !== extendedColors[i + k - 1]) {
            alternatingPairs++;
        }

        if (alternatingPairs === k - 1) {
            count++;
        }
    }

    return count;
};