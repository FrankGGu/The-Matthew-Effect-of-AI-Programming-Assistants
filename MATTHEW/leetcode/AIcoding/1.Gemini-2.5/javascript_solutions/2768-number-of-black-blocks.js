var countBlackBlocks = function(m, n, coordinates) {
    const ans = [0, 0, 0, 0, 0];

    const blackCellsSet = new Set();
    for (const [r, c] of coordinates) {
        blackCellsSet.add(`${r},${c}`);
    }

    const uniqueBlocksToProcess = new Set();

    for (const [r_b, c_b] of coordinates) {
        const potentialBlocks = [
            [r_b, c_b],
            [r_b, c_b - 1],
            [r_b - 1, c_b],
            [r_b - 1, c_b - 1]
        ];

        for (const [R, C] of potentialBlocks) {
            if (R >= 0 && R <= m - 2 && C >= 0 && C <= n - 2) {
                uniqueBlocksToProcess.add(`${R},${C}`);
            }
        }
    }

    for (const blockKey of uniqueBlocksToProcess) {
        const [R_str, C_str] = blockKey.split(',');
        const R = parseInt(R_str);
        const C = parseInt(C_str);

        let currentBlackCount = 0;

        if (blackCellsSet.has(`${R},${C}`)) currentBlackCount++;
        if (blackCellsSet.has(`${R},${C + 1}`)) currentBlackCount++;
        if (blackCellsSet.has(`${R + 1},${C}`)) currentBlackCount++;
        if (blackCellsSet.has(`${R + 1},${C + 1}`)) currentBlackCount++;

        ans[currentBlackCount]++;
    }

    const totalPossibleBlocks = (m - 1) * (n - 1);

    let sumOfNonZeroBlocks = 0;
    for (let i = 1; i <= 4; i++) {
        sumOfNonZeroBlocks += ans[i];
    }

    ans[0] = totalPossibleBlocks - sumOfNonZeroBlocks;

    return ans;
};