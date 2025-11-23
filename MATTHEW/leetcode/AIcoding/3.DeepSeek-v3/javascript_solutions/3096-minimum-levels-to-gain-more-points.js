var minimumLevels = function(possible) {
    const n = possible.length;
    let total = 0;
    for (const num of possible) {
        total += num === 1 ? 1 : -1;
    }

    let current = 0;
    for (let i = 0; i < n - 1; i++) {
        current += possible[i] === 1 ? 1 : -1;
        if (current > total - current) {
            return i + 1;
        }
    }

    return -1;
};