var minimumSwitchingTimes = function(source, target) {
    const freq = new Map();
    const m = source.length;
    const n = source[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const color = source[i][j];
            freq.set(color, (freq.get(color) || 0) + 1);
        }
    }

    let count = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const color = target[i][j];
            if (freq.has(color) && freq.get(color) > 0) {
                freq.set(color, freq.get(color) - 1);
            } else {
                count++;
            }
        }
    }

    return count;
};