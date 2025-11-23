var goodDaysToRobBank = function(security, time) {
    const n = security.length;
    if (n < 2 * time + 1) {
        return [];
    }

    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    left[0] = 1;
    for (let i = 1; i < n; i++) {
        if (security[i] <= security[i - 1]) {
            left[i] = left[i - 1] + 1;
        } else {
            left[i] = 1;
        }
    }

    right[n - 1] = 1;
    for (let i = n - 2; i >= 0; i--) {
        if (security[i] <= security[i + 1]) {
            right[i] = right[i + 1] + 1;
        } else {
            right[i] = 1;
        }
    }

    const result = [];
    for (let i = time; i < n - time; i++) {
        if (left[i] >= time + 1 && right[i] >= time + 1) {
            result.push(i);
        }
    }

    return result;
};