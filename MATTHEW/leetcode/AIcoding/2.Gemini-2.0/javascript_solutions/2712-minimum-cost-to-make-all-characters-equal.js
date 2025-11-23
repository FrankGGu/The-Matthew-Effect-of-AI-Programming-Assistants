var minimumCost = function(s) {
    let n = s.length;
    let cost = 0;
    for (let i = 0; i < n - 1; i++) {
        if (s[i] !== s[i + 1]) {
            cost += Math.min(i + 1, n - i - 1);
        }
    }
    return cost;
};