function minimumCost(s) {
    let totalCost = 0;
    let n = s.length;

    for (let i = 0; i < n; i++) {
        if (i > 0 && s[i] === s[i - 1]) {
            totalCost += i + 1;
        }
    }

    return totalCost;
}