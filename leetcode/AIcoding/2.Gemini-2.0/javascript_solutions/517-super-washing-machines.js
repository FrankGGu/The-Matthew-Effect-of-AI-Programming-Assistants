var findMinMoves = function(machines) {
    const sum = machines.reduce((a, b) => a + b, 0);
    const n = machines.length;
    if (sum % n !== 0) return -1;

    const avg = sum / n;
    let ans = 0;
    let balance = 0;

    for (let i = 0; i < n; i++) {
        balance += machines[i] - avg;
        ans = Math.max(ans, Math.abs(balance), machines[i] - avg);
    }

    return ans;
};