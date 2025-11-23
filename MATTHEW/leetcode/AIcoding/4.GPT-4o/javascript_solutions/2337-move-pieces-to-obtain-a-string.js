var canChange = function(start, target) {
    const s = start.replace(/_/g, '');
    const t = target.replace(/_/g, '');

    if (s !== t) return false;

    let j = 0;
    for (let i = 0; i < start.length; i++) {
        if (start[i] !== '_') {
            while (j < target.length && target[j] === '_') j++;
            if (j === target.length || start[i] !== target[j]) return false;
            if (start[i] === 'L' && i < j) return false;
            if (start[i] === 'R' && i > j) return false;
            j++;
        }
    }
    return true;
};