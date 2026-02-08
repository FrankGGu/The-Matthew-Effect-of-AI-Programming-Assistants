var canChange = function(start, target) {
    let i = 0, j = 0;
    while (i < start.length && j < target.length) {
        while (i < start.length && start[i] === '_') i++;
        while (j < target.length && target[j] === '_') j++;

        if (i === start.length || j === target.length) break;

        if (start[i] !== target[j]) return false;

        if (start[i] === 'L' && i < j) return false;
        if (start[i] === 'R' && i > j) return false;

        i++;
        j++;
    }

    while (i < start.length && start[i] === '_') i++;
    while (j < target.length && target[j] === '_') j++;

    return i === start.length && j === target.length;
};