var kWeakestRows = function(mat, k) {
    const rowStrengths = [];

    for (let i = 0; i < mat.length; i++) {
        let soldiers = 0;
        for (let j = 0; j < mat[i].length; j++) {
            if (mat[i][j] === 1) {
                soldiers++;
            } else {
                break;
            }
        }
        rowStrengths.push({ strength: soldiers, index: i });
    }

    rowStrengths.sort((a, b) => {
        if (a.strength !== b.strength) {
            return a.strength - b.strength;
        }
        return a.index - b.index;
    });

    const result = [];
    for (let i = 0; i < k; i++) {
        result.push(rowStrengths[i].index);
    }

    return result;
};