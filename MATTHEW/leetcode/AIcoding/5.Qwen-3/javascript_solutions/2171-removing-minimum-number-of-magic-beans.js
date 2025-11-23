function minimumRemovalMoney(beans) {
    beans.sort((a, b) => a - b);
    let total = beans.reduce((sum, num) => sum + num, 0);
    let n = beans.length;
    let minRemoval = Infinity;

    for (let i = 0; i < n; i++) {
        let current = beans[i] * (n - i);
        minRemoval = Math.min(minRemoval, total - current);
    }

    return minRemoval;
}