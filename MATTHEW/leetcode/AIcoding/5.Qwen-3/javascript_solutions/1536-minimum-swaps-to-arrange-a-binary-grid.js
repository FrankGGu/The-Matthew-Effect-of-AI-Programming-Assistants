function minSwaps(grid) {
    let n = grid.length;
    let rowHeights = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = n - 1; j >= 0; j--) {
            if (grid[i][j] === '0') count++;
            else break;
        }
        rowHeights[i] = count;
    }

    let swaps = 0;
    for (let i = 0; i < n; i++) {
        let target = n - 1 - i;
        let found = false;
        for (let j = i; j < n; j++) {
            if (rowHeights[j] >= target) {
                found = true;
                break;
            }
        }
        if (!found) return -1;
        for (let j = i; j < n; j++) {
            if (rowHeights[j] >= target) {
                let temp = rowHeights[i];
                rowHeights[i] = rowHeights[j];
                rowHeights[j] = temp;
                swaps++;
                break;
            }
        }
    }

    return swaps;
}