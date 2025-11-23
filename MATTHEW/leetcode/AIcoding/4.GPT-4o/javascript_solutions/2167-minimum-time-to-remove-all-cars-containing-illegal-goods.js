function minimumTimeToRemoveCars(cars) {
    const n = cars.length;
    let dp = new Array(n + 1).fill(0);
    let illegalCount = 0;

    for (let i = 0; i < n; i++) {
        if (cars[i] === 1) illegalCount++;
        dp[i + 1] = dp[i] + (cars[i] === 1 ? 1 : 0);
    }

    let minTime = illegalCount;

    for (let i = 0; i < n; i++) {
        if (cars[i] === 0) {
            minTime = Math.min(minTime, dp[i + 1] + (n - i - 1));
        }
    }

    return minTime;
}