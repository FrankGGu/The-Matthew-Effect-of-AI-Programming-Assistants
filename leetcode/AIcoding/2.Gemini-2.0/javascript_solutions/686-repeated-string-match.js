var repeatedStringMatch = function(a, b) {
    let repeatedA = a;
    let count = 1;
    while (repeatedA.length < b.length) {
        repeatedA += a;
        count++;
    }
    if (repeatedA.includes(b)) {
        return count;
    }
    repeatedA += a;
    count++;
    if (repeatedA.includes(b)) {
        return count;
    }
    return -1;
};