function numWays(n, k) {
    if (n === 0) return 0;
    if (n === 1) return k;
    let prev = k;
    let curr = k * (k - 1);
    for (let i = 2; i < n; i++) {
        let temp = curr;
        curr = (curr + prev) * (k - 1);
        prev = temp;
    }
    return curr;
}