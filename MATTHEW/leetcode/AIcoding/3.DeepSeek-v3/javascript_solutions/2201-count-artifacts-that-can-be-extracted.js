var digArtifacts = function(n, artifacts, dig) {
    const dug = new Set();
    for (const [r, c] of dig) {
        dug.add(`${r},${c}`);
    }

    let count = 0;
    for (const [r1, c1, r2, c2] of artifacts) {
        let canExtract = true;
        for (let r = r1; r <= r2; r++) {
            for (let c = c1; c <= c2; c++) {
                if (!dug.has(`${r},${c}`)) {
                    canExtract = false;
                    break;
                }
            }
            if (!canExtract) break;
        }
        if (canExtract) count++;
    }
    return count;
};