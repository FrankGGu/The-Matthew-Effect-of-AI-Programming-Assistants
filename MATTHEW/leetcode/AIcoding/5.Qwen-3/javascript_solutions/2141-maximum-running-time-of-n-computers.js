function maxRunningTime(batteries, n) {
    batteries.sort((a, b) => b - a);
    let total = batteries.reduce((sum, val) => sum + val, 0);
    let avg = Math.floor(total / n);
    let count = 0;
    for (let i = 0; i < batteries.length; i++) {
        if (batteries[i] > avg) {
            count++;
        } else {
            break;
        }
    }
    return avg + Math.min(count, n - 1);
}