function maxRunTime(n, batteries) {
    let totalBattery = batteries.reduce((a, b) => a + b, 0);
    let left = 1, right = Math.floor(totalBattery / n);

    while (left < right) {
        const mid = Math.floor((left + right + 1) / 2);
        if (batteries.reduce((sum, b) => sum + Math.min(b, mid), 0) >= mid * n) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}