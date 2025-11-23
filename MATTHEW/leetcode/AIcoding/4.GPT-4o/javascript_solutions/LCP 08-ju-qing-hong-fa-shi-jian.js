function getEarliestTime(instructions) {
    const n = instructions.length;
    const dp = Array(n).fill(0);
    const time = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        time[i] = i + 1;
        if (instructions[i] > 0) {
            dp[i] = dp[instructions[i] - 1] + time[i];
        } else {
            dp[i] = time[i];
        }
    }

    return Math.max(...dp);
}