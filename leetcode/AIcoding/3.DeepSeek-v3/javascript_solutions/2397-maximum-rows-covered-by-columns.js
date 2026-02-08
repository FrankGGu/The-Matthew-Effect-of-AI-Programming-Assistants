var maximumRows = function(matrix, numSelect) {
    const m = matrix.length;
    const n = matrix[0].length;
    let maxRows = 0;

    const backtrack = (start, selected) => {
        if (selected.length === numSelect) {
            let count = 0;
            for (let i = 0; i < m; i++) {
                let covered = true;
                for (let j = 0; j < n; j++) {
                    if (matrix[i][j] === 1 && !selected.includes(j)) {
                        covered = false;
                        break;
                    }
                }
                if (covered) {
                    count++;
                }
            }
            maxRows = Math.max(maxRows, count);
            return;
        }

        for (let j = start; j < n; j++) {
            selected.push(j);
            backtrack(j + 1, selected);
            selected.pop();
        }
    };

    backtrack(0, []);
    return maxRows;
};