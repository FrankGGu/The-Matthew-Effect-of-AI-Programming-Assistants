var kWeakestRows = function(mat, k) {
    const rows = mat.length;
    const strengths = [];

    for (let i = 0; i < rows; i++) {
        let strength = 0;
        for (let j = 0; j < mat[i].length; j++) {
            if (mat[i][j] === 1) {
                strength++;
            } else {
                break;
            }
        }
        strengths.push({ index: i, strength: strength });
    }

    strengths.sort((a, b) => {
        if (a.strength === b.strength) {
            return a.index - b.index;
        }
        return a.strength - b.strength;
    });

    const result = [];
    for (let i = 0; i < k; i++) {
        result.push(strengths[i].index);
    }

    return result;
};