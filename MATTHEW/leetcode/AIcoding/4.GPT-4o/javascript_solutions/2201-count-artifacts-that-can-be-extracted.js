var countArtifacts = function(n, artifacts) {
    const grid = Array.from({ length: n }, () => Array(n).fill(0));
    for (const [x1, y1, x2, y2] of artifacts) {
        for (let i = x1; i <= x2; i++) {
            for (let j = y1; j <= y2; j++) {
                grid[i][j]++;
            }
        }
    }

    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) count++;
        }
    }

    return count;
};