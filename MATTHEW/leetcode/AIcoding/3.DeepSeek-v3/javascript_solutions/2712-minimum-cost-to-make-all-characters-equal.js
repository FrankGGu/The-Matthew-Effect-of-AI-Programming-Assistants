var minimumCost = function(s) {
    let cost = 0;
    const n = s.length;
    for (let i = 1; i < n; i++) {
        if (s[i] !== s[i - 1]) {
            cost += Math.min(i, n - i);
        }
    }
    return cost;
};