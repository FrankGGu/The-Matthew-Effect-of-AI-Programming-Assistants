var findLargestInteger = function(A) {
    const n = A.length;
    const set = new Set(A);

    for (let i = 10 ** 9; i >= 1; i--) {
        if (!set.has(i) && !set.has(i + 1)) {
            return i;
        }
    }
    return -1;
};