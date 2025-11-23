function maxConsecutive(n, special) {
    special.sort((a, b) => a - b);
    let max = 0;
    let prev = 0;
    for (let i = 0; i < special.length; i++) {
        max = Math.max(max, special[i] - prev - 1);
        prev = special[i];
    }
    max = Math.max(max, n - prev);
    return max;
}