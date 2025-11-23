function countPairs(n, red, blue) {
    const redSet = new Set(red);
    const blueSet = new Set(blue);
    let count = 0;
    for (let i = 0; i < n; i++) {
        if (redSet.has(i) && blueSet.has(i)) {
            count++;
        }
    }
    return count;
}