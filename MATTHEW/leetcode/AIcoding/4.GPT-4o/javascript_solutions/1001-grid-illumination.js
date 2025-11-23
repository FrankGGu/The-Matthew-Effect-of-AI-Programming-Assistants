class Solution {
    illuminate(grid, lamps, queries) {
        const n = grid.length;
        const lampSet = new Set();
        const row = new Array(n).fill(0);
        const col = new Array(n).fill(0);
        const diag1 = new Array(2 * n - 1).fill(0);
        const diag2 = new Array(2 * n - 1).fill(0);

        for (const [r, c] of lamps) {
            if (!lampSet.has(`${r},${c}`)) {
                lampSet.add(`${r},${c}`);
                row[r]++;
                col[c]++;
                diag1[r - c + n - 1]++;
                diag2[r + c]++;
            }
        }

        const result = [];

        for (const [r, c] of queries) {
            result.push(row[r] > 0 || col[c] > 0 || diag1[r - c + n - 1] > 0 || diag2[r + c] > 0 ? 1 : 0);

            for (let i = r - 1; i <= r + 1; i++) {
                for (let j = c - 1; j <= c + 1; j++) {
                    if (i >= 0 && i < n && j >= 0 && j < n) {
                        if (lampSet.has(`${i},${j}`)) {
                            lampSet.delete(`${i},${j}`);
                            row[i]--;
                            col[j]--;
                            diag1[i - j + n - 1]--;
                            diag2[i + j]--;
                        }
                    }
                }
            }
        }

        return result;
    }
}