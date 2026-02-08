var goodDaysToRob = function(security, time) {
    const n = security.length;
    const result = [];
    if (n < 2 * time + 1) {
        return result;
    }

    const nonIncreasing = new Array(n).fill(0);
    const nonDecreasing = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        if (security[i] <= security[i - 1]) {
            nonIncreasing[i] = nonIncreasing[i - 1] + 1;
        }
        if (security[n - 1 - i] <= security[n - i]) {
            nonDecreasing[n - 1 - i] = nonDecreasing[n - i] + 1;
        }
    }

    for (let i = time; i < n - time; i++) {
        if (nonIncreasing[i] >= time && nonDecreasing[i] >= time) {
            result.push(i);
        }
    }

    return result;
};