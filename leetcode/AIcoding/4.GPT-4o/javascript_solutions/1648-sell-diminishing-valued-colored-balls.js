var maxProfit = function(p, n) {
    p.sort((a, b) => b - a);
    let profit = 0;
    for (let i = 0; i < p.length; i++) {
        let count = Math.min(n, i + 1);
        profit += p[i] * count;
        n -= count;
        if (n <= 0) break;
    }
    return profit;
};