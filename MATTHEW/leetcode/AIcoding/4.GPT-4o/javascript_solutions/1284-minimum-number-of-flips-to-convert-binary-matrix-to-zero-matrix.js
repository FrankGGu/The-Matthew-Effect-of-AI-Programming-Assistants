function minFlips(matrix) {
    const rows = matrix.length, cols = matrix[0].length;
    const totalStates = 1 << cols;
    let minFlips = Infinity;

    for (let state = 0; state < totalStates; state++) {
        let flips = 0;
        for (let r = 0; r < rows; r++) {
            let rowFlips = 0;
            for (let c = 0; c < cols; c++) {
                if ((state & (1 << c)) !== 0) rowFlips ^= matrix[r][c];
            }
            if (rowFlips) flips++;
        }
        if (flips < minFlips) {
            let valid = true;
            for (let r = 0; r < rows; r++) {
                let rowFlips = 0;
                for (let c = 0; c < cols; c++) {
                    if ((state & (1 << c)) !== 0) rowFlips ^= 1;
                }
                if ((rowFlips ^ matrix[r].reduce((a, b) => a ^ b, 0)) !== 0) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                minFlips = Math.min(minFlips, flips);
            }
        }
    }
    return minFlips === Infinity ? -1 : minFlips;
}