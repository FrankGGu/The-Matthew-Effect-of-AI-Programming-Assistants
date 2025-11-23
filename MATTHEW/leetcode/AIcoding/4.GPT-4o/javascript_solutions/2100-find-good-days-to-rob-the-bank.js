function goodDaysToRobBank(security, time) {
    const n = security.length;
    const result = [];
    const nonIncreasing = new Array(n).fill(0);

    for (let i = n - 2; i >= 0; i--) {
        if (security[i] >= security[i + 1]) {
            nonIncreasing[i] = nonIncreasing[i + 1] + 1;
        }
    }

    for (let i = 0; i <= n - time - 1; i++) {
        if (nonIncreasing[i] >= time && nonIncreasing[i + time] >= time) {
            result.push(i);
        }
    }

    return result;
}