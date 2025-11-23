var kWeakestRows = function(mat, k) {
    const rowStrengths = mat.map((row, index) => {
        const strength = row.reduce((sum, num) => sum + num, 0);
        return { index, strength };
    });

    rowStrengths.sort((a, b) => {
        if (a.strength !== b.strength) {
            return a.strength - b.strength;
        } else {
            return a.index - b.index;
        }
    });

    return rowStrengths.slice(0, k).map(item => item.index);
};