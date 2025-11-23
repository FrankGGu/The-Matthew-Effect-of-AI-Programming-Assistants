function findMinMoves(machines) {
    const total = machines.reduce((sum, num) => sum + num, 0);
    if (total % machines.length !== 0) return -1;
    const avg = total / machines.length;
    let res = 0;
    let balance = 0;
    for (let i = 0; i < machines.length; i++) {
        balance += machines[i] - avg;
        res = Math.max(res, Math.abs(balance), machines[i] - avg);
    }
    return res;
}