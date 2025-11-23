var isCovered = function(ranges, left, right) {
    const covered = new Array(101).fill(false);
    for (const [start, end] of ranges) {
        for (let i = start; i <= end; i++) {
            covered[i] = true;
        }
    }
    for (let i = left; i <= right; i++) {
        if (!covered[i]) return false;
    }
    return true;
};