var findMinMoves = function(machines) {
    const total = machines.reduce((a, b) => a + b, 0);
    const n = machines.length;
    if (total % n !== 0) return -1;
    const avg = total / n;
    let res = 0, balance = 0;
    for (let i = 0; i < n; i++) {
        balance += machines[i] - avg;
        res = Math.max(res, Math.abs(balance), machines[i] - avg);
    }
    return res;
};