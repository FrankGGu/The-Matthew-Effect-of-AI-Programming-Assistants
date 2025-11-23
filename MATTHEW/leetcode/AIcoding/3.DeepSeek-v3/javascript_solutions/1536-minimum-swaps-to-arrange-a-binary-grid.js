var minSwaps = function(grid) {
    const n = grid.length;
    const trailingZeros = [];

    for (let i = 0; i < n; i++) {
        let zeros = 0;
        for (let j = n - 1; j >= 0; j--) {
            if (grid[i][j] === 0) {
                zeros++;
            } else {
                break;
            }
        }
        trailingZeros.push(zeros);
    }

    let swaps = 0;

    for (let i = 0; i < n; i++) {
        const requiredZeros = n - 1 - i;
        let found = -1;

        for (let j = i; j < n; j++) {
            if (trailingZeros[j] >= requiredZeros) {
                found = j;
                break;
            }
        }

        if (found === -1) return -1;

        for (let j = found; j > i; j--) {
            [trailingZeros[j], trailingZeros[j - 1]] = [trailingZeros[j - 1], trailingZeros[j]];
            swaps++;
        }
    }

    return swaps;
};