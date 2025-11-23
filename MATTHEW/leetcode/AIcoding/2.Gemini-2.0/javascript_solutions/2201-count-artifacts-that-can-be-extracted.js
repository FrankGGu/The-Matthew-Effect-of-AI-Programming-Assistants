var digArtifacts = function(n, artifacts, dug) {
    const dugSet = new Set();
    for (const [row, col] of dug) {
        dugSet.add(row * n + col);
    }

    let count = 0;
    for (const [r1, c1, r2, c2] of artifacts) {
        let canExtract = true;
        for (let i = r1; i <= r2; i++) {
            for (let j = c1; j <= c2; j++) {
                if (!dugSet.has(i * n + j)) {
                    canExtract = false;
                    break;
                }
            }
            if (!canExtract) {
                break;
            }
        }
        if (canExtract) {
            count++;
        }
    }

    return count;
};