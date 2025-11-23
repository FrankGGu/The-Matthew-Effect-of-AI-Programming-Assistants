var minimumPossibleSum = function(n, target) {
    const used = new Set();
    let sum = 0;
    let current = 1;

    while (used.size < n) {
        if (!used.has(target - current)) {
            used.add(current);
            sum += current;
        }
        current++;
    }

    return sum;
};