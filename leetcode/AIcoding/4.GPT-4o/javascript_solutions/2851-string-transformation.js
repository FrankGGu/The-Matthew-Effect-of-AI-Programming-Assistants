var canTransform = function(start, end) {
    if (start.replace(/X/g, '') !== end.replace(/X/g, '')) return false;

    let i = 0, j = 0;
    while (i < start.length || j < end.length) {
        while (i < start.length && start[i] === 'X') i++;
        while (j < end.length && end[j] === 'X') j++;

        if (i < start.length && j < end.length) {
            if (start[i] !== end[j]) return false;
            if (start[i] === 'L' && i < j) return false;
            if (start[i] === 'R' && i > j) return false;
            i++;
            j++;
        } else if (i < start.length || j < end.length) {
            return false;
        }
    }
    return true;
};