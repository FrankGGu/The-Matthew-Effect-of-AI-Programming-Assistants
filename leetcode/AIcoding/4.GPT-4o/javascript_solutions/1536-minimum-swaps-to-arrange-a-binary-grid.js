function minSwaps(grid) {
    const n = grid.length;
    const zeros = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = n - 1; j >= 0; j--) {
            if (grid[i][j] === 0) count++;
            else break;
        }
        zeros[i] = count;
    }

    let swaps = 0;
    for (let i = 0; i < n; i++) {
        if (zeros[i] < n - i - 1) {
            let j = i;
            while (j < n && zeros[j] < n - i - 1) j++;
            if (j === n) return -1;
            for (let k = j; k > i; k--) {
                [zeros[k], zeros[k - 1]] = [zeros[k - 1], zeros[k]];
                swaps++;
            }
        }
    }

    return swaps;
}