function minimumPossibleSum(n, target) {
    const seen = new Set();
    let sum = 0;
    let current = 1;

    while (n > 0) {
        if (!seen.has(current) && current < target) {
            sum += current;
            seen.add(current);
            n--;
        }
        current++;
    }

    return sum;
}