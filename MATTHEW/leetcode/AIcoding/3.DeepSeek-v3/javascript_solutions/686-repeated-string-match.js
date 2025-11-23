var repeatedStringMatch = function(a, b) {
    let count = Math.ceil(b.length / a.length);
    let repeated = a.repeat(count);
    if (repeated.includes(b)) {
        return count;
    }
    repeated += a;
    if (repeated.includes(b)) {
        return count + 1;
    }
    return -1;
};