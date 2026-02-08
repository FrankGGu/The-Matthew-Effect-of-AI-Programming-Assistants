var isCovered = function(ranges, left, right) {
    const covered = new Array(51).fill(false);

    for (const range of ranges) {
        const start = range[0];
        const end = range[1];
        for (let i = start; i <= end; i++) {
            covered[i] = true;
        }
    }

    for (let i = left; i <= right; i++) {
        if (!covered[i]) {
            return false;
        }
    }

    return true;
};