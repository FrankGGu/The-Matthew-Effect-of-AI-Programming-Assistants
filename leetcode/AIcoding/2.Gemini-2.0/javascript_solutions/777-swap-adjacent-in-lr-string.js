var canTransform = function(start, end) {
    let i = 0, j = 0;
    while (i < start.length && j < end.length) {
        while (i < start.length && start[i] === 'X') i++;
        while (j < end.length && end[j] === 'X') j++;

        if (i === start.length && j === end.length) return true;
        if (i === start.length || j === end.length) return false;

        if (start[i] !== end[j]) return false;

        if (start[i] === 'L' && i < j) return false;
        if (start[i] === 'R' && i > j) return false;

        i++;
        j++;
    }

    while (i < start.length && start[i] === 'X') i++;
    while (j < end.length && end[j] === 'X') j++;

    return i === start.length && j === end.length;
};