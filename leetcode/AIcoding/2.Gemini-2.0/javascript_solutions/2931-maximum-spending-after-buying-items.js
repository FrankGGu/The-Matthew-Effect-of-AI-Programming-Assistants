var maximumSpending = function(costs) {
    const n = costs.length;
    const m = costs[0].length;
    const last = new Array(n).fill(m - 1);
    let ans = 0;

    for (let i = 0; i < n * m; i++) {
        let maxVal = -1;
        let maxIdx = -1;

        for (let j = 0; j < n; j++) {
            if (last[j] >= 0 && costs[j][last[j]] > maxVal) {
                maxVal = costs[j][last[j]];
                maxIdx = j;
            }
        }

        ans += maxVal;
        last[maxIdx]--;
    }

    return ans;
};