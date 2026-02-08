var matrixRankTransform = function(matrix) {
    const R = matrix.length;
    const C = matrix[0].length;

    const ans = new Array(R).fill(0).map(() => new Array(C).fill(0));
    const prevRowMaxRank = new Array(R).fill(0);
    const prevColMaxRank = new Array(C).fill(0);

    const allCells = [];
    for (let r = 0; r < R; r++) {
        for (let c = 0; c < C; c++) {
            allCells.push([matrix[r][c], r, c]);
        }
    }

    allCells.sort((a, b) => a[0] - b[0]);

    let i = 0;
    while (i < allCells.length) {
        let j = i;
        const currentGroupCells = [];
        while (j < allCells.length && allCells[j][0] === allCells[i][0]) {
            currentGroupCells.push(allCells[j]);
            j++;
        }

        const parent = new Array(R + C).fill(0).map((_, idx) => idx);

        const find = (k) => {
            if (parent[k] === k) return k;
            return parent[k] = find(parent[k]);
        };

        const union = (k1, k2) => {
            const root1 = find(k1);
            const root2 = find(k2);
            if (root1 !== root2) {
                parent[root2] = root1;
            }
        };

        for (const [, r, c] of currentGroupCells) {
            union(r, c + R); 
        }

        const componentMaxRanks = new Map(); 

        for (const [, r, c] of currentGroupCells) {
            const root = find(r);
            const currentMaxForCell = Math.max(prevRowMaxRank[r], prevColMaxRank[c]);
            componentMaxRanks.set(root, Math.max(componentMaxRanks.get(root) || 0, currentMaxForCell));
        }

        for (const [, r, c] of currentGroupCells) {
            const root = find(r);
            const newRank = 1 + componentMaxRanks.get(root);
            ans[r][c] = newRank;
            prevRowMaxRank[r] = Math.max(prevRowMaxRank[r], newRank);
            prevColMaxRank[c] = Math.max(prevColMaxRank[c], newRank);
        }

        i = j; 
    }

    return ans;
};