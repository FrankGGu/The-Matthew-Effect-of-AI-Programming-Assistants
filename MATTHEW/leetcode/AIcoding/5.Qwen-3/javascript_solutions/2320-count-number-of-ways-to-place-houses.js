function countHousePlacements(n) {
    if (n === 0) return 0;
    if (n === 1) return 1;

    let prev = 1;
    let curr = 1;

    for (let i = 2; i <= n; i++) {
        let next = (prev + curr) % (10**9 + 7);
        prev = curr;
        curr = next;
    }

    return (curr * curr) % (10**9 + 7);
}