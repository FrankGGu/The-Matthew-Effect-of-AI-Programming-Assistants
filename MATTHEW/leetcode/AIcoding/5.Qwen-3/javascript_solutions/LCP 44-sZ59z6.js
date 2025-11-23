function numColor(n) {
    if (n === 0) return 0;
    let count = 1;
    let current = 1;
    while (current < n) {
        current *= 2;
        count++;
    }
    return count;
}