var differenceOfDistinctValues = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const answer = new Array(m).fill().map(() => new Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const topLeft = new Set();
            let r = i - 1, c = j - 1;
            while (r >= 0 && c >= 0) {
                topLeft.add(grid[r][c]);
                r--;
                c--;
            }

            const bottomRight = new Set();
            r = i + 1, c = j + 1;
            while (r < m && c < n) {
                bottomRight.add(grid[r][c]);
                r++;
                c++;
            }

            answer[i][j] = Math.abs(topLeft.size - bottomRight.size);
        }
    }

    return answer;
};