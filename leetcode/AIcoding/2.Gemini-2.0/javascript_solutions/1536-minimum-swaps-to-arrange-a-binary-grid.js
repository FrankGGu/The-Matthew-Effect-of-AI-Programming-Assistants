var minSwaps = function(grid) {
    const n = grid.length;
    const rights = [];
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = n - 1; j >= 0; j--) {
            if (grid[i][j] === 0) {
                count++;
            } else {
                break;
            }
        }
        rights.push(count);
    }

    let swaps = 0;
    for (let i = 0; i < n; i++) {
        let required = n - 1 - i;
        let j = i;
        while (j < n && rights[j] < required) {
            j++;
        }
        if (j === n) {
            return -1;
        }
        for (let k = j; k > i; k--) {
            [rights[k], rights[k - 1]] = [rights[k - 1], rights[k]];
            swaps++;
        }
    }

    return swaps;
};