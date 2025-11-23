var minDeletionSize = function(strs) {
    const R = strs.length;
    if (R <= 1) {
        return 0;
    }
    const C = strs[0].length;

    let deletedCount = 0;
    const isSorted = new Array(R - 1).fill(false);

    for (let j = 0; j < C; j++) {
        let canKeepColumn = true;
        for (let i = 0; i < R - 1; i++) {
            if (isSorted[i]) {
                continue;
            }
            if (strs[i][j] > strs[i+1][j]) {
                canKeepColumn = false;
                break;
            }
        }

        if (!canKeepColumn) {
            deletedCount++;
        } else {
            for (let i = 0; i < R - 1; i++) {
                if (!isSorted[i] && strs[i][j] < strs[i+1][j]) {
                    isSorted[i] = true;
                }
            }

            let allPairsSorted = true;
            for (let i = 0; i < R - 1; i++) {
                if (!isSorted[i]) {
                    allPairsSorted = false;
                    break;
                }
            }
            if (allPairsSorted) {
                return deletedCount;
            }
        }
    }

    return deletedCount;
};