function minCostII(costs) {
    if (costs.length === 0 || costs[0].length === 0) return 0;
    const n = costs.length;
    const k = costs[0].length;
    let prev = costs[0];
    for (let i = 1; i < n; i++) {
        const curr = new Array(k).fill(0);
        for (let j = 0; j < k; j++) {
            let minCost = Infinity;
            for (let m = 0; m < k; m++) {
                if (m !== j) {
                    minCost = Math.min(minCost, prev[m]);
                }
            }
            curr[j] = costs[i][j] + minCost;
        }
        prev = curr;
    }
    return Math.min(...prev);
}