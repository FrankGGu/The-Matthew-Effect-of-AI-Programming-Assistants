function temperatureTrend(temperature) {
    const n = temperature.length;
    const result = [];
    for (let i = 1; i < n; i++) {
        const prev = temperature[i - 1];
        const curr = temperature[i];
        if (curr > prev) {
            result.push(1);
        } else if (curr < prev) {
            result.push(-1);
        } else {
            result.push(0);
        }
    }
    return result;
}