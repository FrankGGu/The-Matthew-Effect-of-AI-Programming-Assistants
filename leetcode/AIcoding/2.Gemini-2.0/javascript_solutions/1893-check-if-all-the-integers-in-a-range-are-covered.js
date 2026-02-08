var isCovered = function(ranges, left, right) {
    const covered = new Array(51).fill(false);
    for (const range of ranges) {
        for (let i = range[0]; i <= range[1]; i++) {
            if (i >= 1 && i <= 50) {
                covered[i] = true;
            }
        }
    }

    for (let i = left; i <= right; i++) {
        if (!covered[i]) {
            return false;
        }
    }

    return true;
};