var pyramidTransition = function(bottom, allowed) {
    const allowedMap = new Map();
    for (const triplet of allowed) {
        const base = triplet[0] + triplet[1];
        if (!allowedMap.has(base)) {
            allowedMap.set(base, []);
        }
        allowedMap.get(base).push(triplet[2]);
    }

    const canFormPyramid = (currentRow) => {
        if (currentRow.length === 1) return true;
        const nextRow = [];
        for (let i = 0; i < currentRow.length - 1; i++) {
            const base = currentRow[i] + currentRow[i + 1];
            if (!allowedMap.has(base)) return false;
            nextRow.push(allowedMap.get(base));
        }
        const dfs = (index) => {
            if (index === nextRow.length) return true;
            for (const char of nextRow[index]) {
                if (dfs(index + 1)) return true;
            }
            return false;
        };
        return dfs(0);
    };

    return canFormPyramid(bottom);
};