var minSwaps = function(grid) {
    const n = grid.length;
    const trailingZeros = new Array(n);

    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = n - 1; j >= 0; j--) {
            if (grid[i][j] === 0) {
                count++;
            } else {
                break;
            }
        }
        trailingZeros[i] = count;
    }

    let totalSwaps = 0;

    for (let i = 0; i < n; i++) {
        const requiredZeros = n - 1 - i;
        let targetIndex = -1;

        for (let j = i; j < n; j++) {
            if (trailingZeros[j] >= requiredZeros) {
                targetIndex = j;
                break;
            }
        }

        if (targetIndex === -1) {
            return -1; // Cannot form a valid grid
        }

        // Add swaps needed to bring this row to position i
        totalSwaps += (targetIndex - i);

        // Move the found row to position i in the trailingZeros array
        const valueToMove = trailingZeros[targetIndex];
        trailingZeros.splice(targetIndex, 1); // Remove from targetIndex
        trailingZeros.splice(i, 0, valueToMove); // Insert at i
    }

    return totalSwaps;
};