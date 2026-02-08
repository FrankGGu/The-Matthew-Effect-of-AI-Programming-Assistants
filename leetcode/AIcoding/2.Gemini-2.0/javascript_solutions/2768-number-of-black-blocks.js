var countBlackBlocks = function(m, n, coordinates) {
    const grid = new Map();
    for (const [x, y] of coordinates) {
        grid.set(`${x},${y}`, true);
    }

    const counts = new Array(5).fill(0);
    for (const [x, y] of coordinates) {
        for (let i = 0; i < 2; i++) {
            for (let j = 0; j < 2; j++) {
                const r = x - i;
                const c = y - j;

                if (r >= 1 && r < m && c >= 1 && c < n) {
                    let blackCount = 0;
                    if (grid.has(`${r},${c}`)) blackCount++;
                    if (grid.has(`${r+1},${c}`)) blackCount++;
                    if (grid.has(`${r},${c+1}`)) blackCount++;
                    if (grid.has(`${r+1},${c+1}`)) blackCount++;
                    counts[blackCount]++;
                }
            }
        }
    }

    const ans = new Array(5).fill(0);
    let totalSquares = (m - 1) * (n - 1);
    for (let i = 1; i <= 4; i++) {
        ans[i] = counts[i];
        totalSquares -= counts[i];
    }
    ans[0] = totalSquares;

    return ans;
};